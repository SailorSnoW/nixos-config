return {
    "rose-pine",
    priority = 1000,
    after = function()
        local function system_prefers_dark()
            local sysname = vim.uv.os_uname().sysname

            if sysname == "Darwin" then
                local output = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
                return vim.v.shell_error == 0 and output:find("Dark", 1, true) ~= nil
            end

            if vim.fn.executable("gsettings") == 1 then
                local color_scheme =
                    vim.fn.system({ "gsettings", "get", "org.gnome.desktop.interface", "color-scheme" })
                if vim.v.shell_error == 0 then
                    if color_scheme:find("prefer-dark", 1, true) ~= nil then
                        return true
                    end

                    if color_scheme:find("prefer-light", 1, true) ~= nil then
                        return false
                    end
                end

                local gtk_theme = vim.fn.system({ "gsettings", "get", "org.gnome.desktop.interface", "gtk-theme" })
                if vim.v.shell_error == 0 then
                    return gtk_theme:lower():find("dark", 1, true) ~= nil
                end
            end

            return vim.o.background ~= "light"
        end

        local current_variant = nil
        local function apply_system_variant()
            local prefers_dark = system_prefers_dark()
            local variant = prefers_dark and "rose-pine-moon" or "rose-pine-dawn"

            if current_variant == variant then
                return
            end

            vim.o.background = prefers_dark and "dark" or "light"
            vim.cmd("colorscheme " .. variant)
            current_variant = variant
        end

        require("rose-pine").setup({
            styles = {
                transparency = true,
            },
        })

        apply_system_variant()

        vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
            group = vim.api.nvim_create_augroup("rose-pine-system-theme", { clear = true }),
            callback = apply_system_variant,
        })

        local poll_group = vim.api.nvim_create_augroup("rose-pine-system-theme-poll", { clear = true })
        local poll_timer = vim.uv.new_timer()
        if poll_timer ~= nil then
            poll_timer:start(
                0,
                3000,
                vim.schedule_wrap(function()
                    if vim.g.colors_name ~= nil then
                        apply_system_variant()
                    end
                end)
            )

            vim.api.nvim_create_autocmd("VimLeavePre", {
                group = poll_group,
                callback = function()
                    if poll_timer ~= nil then
                        poll_timer:stop()
                        poll_timer:close()
                        poll_timer = nil
                    end
                end,
            })
        end

        vim.api.nvim_create_user_command("RosePineSyncSystem", apply_system_variant, {
            desc = "Sync rose-pine variant with system theme",
        })
    end,
}
