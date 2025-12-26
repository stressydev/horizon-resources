RegisterNUICallback('config', function(_data, cb)
    cb({
        -- Main background color: deep translucent purple
        mainColor = GetConvar('qbx_chat:mainColor', '#2a0033cc'), -- dark purple w/ transparency

        -- Border accent: vibrant neon purple
        borderColor = GetConvar('qbx_chat:borderColor', '#9b30ff'),

        -- Text color: clean white for readability
        textColor = GetConvar('qbx_chat:textColor', '#ffffff'),

        -- Faint text color: soft lavender for secondary info
        faintColor = GetConvar('qbx_chat:faintColor', '#d8b4f8'),

        -- Fonts: modern sans-serif
        fontFamily = GetConvar('qbx_chat:fontFamily', "'Segoe UI', Arial, Helvetica, sans-serif"),
        -- consoleFontFamily = GetConvar('qbx_chat:consoleFontFamily', 'monospace'),
        suggestionFontFamily = GetConvar('qbx_chat:suggestionFontFamily', 'monospace'),

        -- Input icon: you can swap this for a purple-themed asset
        inputIconUrl = GetConvar('qbx_chat:inputIconUrl', 'https://cfx-nui-qbx_chat_theme/theme/icons/hcr.gif'),
        -- messageIconUrl = GetConvar('qbx_chat:messageIconUrl', 'https://cfx-nui-qbx_chat_theme/theme/icons/message.svg'),
        -- consoleIconUrl = GetConvar('qbx_chat:consoleIconUrl', 'https://cfx-nui-qbx_chat_theme/theme/icons/console.svg'),
        -- joinIconUrl = GetConvar('qbx_chat:joinIconUrl', 'https://cfx-nui-qbx_chat_theme/theme/icons/join.svg'),
        -- quitIconUrl = GetConvar('qbx_chat:quitIconUrl', 'https://cfx-nui-qbx_chat_theme/theme/icons/quit.svg'),
        -- userIconUrl = GetConvar('qbx_chat:userIconUrl', 'https://cfx-nui-qbx_chat_theme/theme/icons/user.svg'),
    })
end)
