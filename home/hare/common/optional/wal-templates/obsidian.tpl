/*
HyprLuna Obsidian Theme

@author Nixev
@version 1.0.0
*/

.theme-dark {
    /* Keep soft backgrounds */
    --background-primary: #{{ background | strip }};
    --background-primary-alt: {{ background | lighten(0.2) }}40;
    --background-secondary: {{ background | lighten(0.2) }}20;
    --background-secondary-alt: {{ background | lighten(0.2) }}10;

    /* Subtle borders and modifiers */
    --background-modifier-border: #colors.outline.default.hex_stripped20;
    --background-modifier-form-field: {{ background | lighten(0.2) }}20;
    --background-modifier-form-field-highlighted: {{ background | lighten(0.2) }}30;
    --background-modifier-box-shadow: rgba(0, 0, 0, 0.05);
    --background-modifier-success: #{{color1}}40;
    --background-modifier-error: #colors.error.default.hex_stripped40;
    --background-modifier-error-hover: #colors.error_container.default.hex_stripped30;
    --background-modifier-cover: rgba(0, 0, 0, 0.2);

    /* 94% opacity text */
    --text-normal: #{{ foreground | strip }}f0;
    --text-muted: #colors.on_surface_variant.default.hex_strippedf0;
    --text-faint: #colors.on_surface_variant.default.hex_strippedf0;
    --text-error: #colors.error.default.hex_strippedf0;
    --text-error-hover: #colors.error.default.hex_strippedf0;

    /* Subtle highlights */
    --text-highlight-bg: {{ color1 }}15;
    --text-highlight-bg-active: {{ color1 }}25;
    --text-selection: {{ color1 }}25;
    --text-on-accent: #colors.on_primary.default.hex_strippedf0;

    /* Clear interactive elements at 94% */
    --interactive-normal: {{ background | lighten(0.2) }}20;
    --interactive-hover: {{ background | lighten(0.2) }}30;
    --interactive-accent: #{{color1}}f0;
    --interactive-accent-hover: #{colors.primary_container.default.hex_stripped}}f0;
    --interactive-success: #{{color1}}f0;

    /* Subtle scrollbars */
    --scrollbar-bg: {{ background | lighten(0.2) }}10;
    --scrollbar-thumb-bg: #{{color1}}20;
    --scrollbar-active-thumb-bg: #{{color1}}30;

    /* Headings at 94% */
    --text-title-h1: #{{ foreground | strip }}f0;
    --text-title-h2: #{colors.on_surface_variant.default.hex_stripped}}f0;
    --text-title-h3: #{colors.on_surface_variant.default.hex_stripped}}f0;
    --text-title-h4: #{colors.on_surface_variant.default.hex_stripped}}f0;
    --text-title-h5: #{colors.on_surface_variant.default.hex_stripped}}f0;
    --text-title-h6: #{colors.on_surface_variant.default.hex_stripped}}f0;

    /* Links at 94% */
    --text-link: #{{color1}}f0;
    --text-a: #{{color1}}f0;
    --text-a-hover: #{{color1}}f0;

    /* Tags at 94% with subtle backgrounds */
    --tag-color: #{colors.secondary.default.hex_stripped}}f0;
    --tag-background: #{colors.secondary.default.hex_stripped}}15;
    --tag-background-hover: #{colors.secondary.default.hex_stripped}}25;

    --titlebar-text-color-focused: #{{ foreground | strip }}f0;

    /* Clear text on subtle backgrounds */
    --inline-code-background: {{ background | lighten(0.2) }}25;
    --code-block-background: {{ background | lighten(0.2) }}15;

    /* Checkboxes at 94% */
    --checkbox-color: #{{color1}}f0;
    --checkbox-color-hover: #{colors.primary_container.default.hex_stripped}}f0;
    --checkbox-border-color: #{colors.outline.default.hex_stripped}}f0;
    --checkbox-border-color-hover: #{{color1}}f0;

    /* Clear text on subtle backgrounds */
    --table-header-background: {{ background | lighten(0.2) }}25;
    --table-header-background-hover: {{ background | lighten(0.2) }}35;
    --table-row-background-hover: {{ background | lighten(0.2) }}15;

    /* Graph colors at 94% */
    --graph-line: #{colors.outline.default.hex_stripped}}f0;
    --graph-node: #{{color1}}f0;
    --graph-node-unresolved: #{colors.error.default.hex_stripped}}f0;
    --graph-node-focused: #{colors.secondary.default.hex_stripped}}f0;

    --calendar-week-number: #{colors.outline.default.hex_stripped}}f0;
    --calendar-selected-day: #{{color1}}f0;

    /* Navigation at 94% with subtle backgrounds */
    --nav-item-color: #{{ foreground | strip }}f0;
    --nav-item-background-hover: {{ background | lighten(0.2) }}25;
    --nav-item-background-active: #{{color1}}15;
    --nav-file-tag: #{colors.secondary.default.hex_stripped}}f0;

    /* Blockquotes at 94% */
    --blockquote-border: #{{color1}}f0;
    --blockquote-background: {{ background | lighten(0.2) }}15;

    /* Icons at 94% */
    --icon-color: #{{ foreground | strip }}f0;
    --icon-color-hover: #{{color1}}f0;
    --icon-color-active: #{{color1}}f0;

    /* Tabs at 94% with subtle backgrounds */
    --tab-text-color: #{{ foreground | strip }}f0;
    --tab-text-color-focused: #{{color1}}f0;
    --tab-text-color-focused-active: #{colors.on_primary.default.hex_stripped}}f0;
    --tab-background-focused: #{{color1}}15;
    --tab-background-focused-active: #{{color1}}25;
}

/* Custom styling */
.theme-dark {
    --font-text-theme: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Ubuntu, sans-serif;
    --font-editor-theme: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Ubuntu, sans-serif;
    --font-monospace-theme: 'Jetbrains Mono', 'Fira Code', Menlo, Monaco, Consolas, 'Courier New', monospace;
}

/* Headers */
.markdown-preview-view h1,
.markdown-source-view.mod-cm6 .HyperMD-header-1 {
    color: var(--text-title-h1);
    font-weight: 600;
}

.markdown-preview-view h2,
.markdown-source-view.mod-cm6 .HyperMD-header-2 {
    color: var(--text-title-h2);
    font-weight: 600;
}

.markdown-preview-view h3,
.markdown-source-view.mod-cm6 .HyperMD-header-3 {
    color: var(--text-title-h3);
    font-weight: 500;
}

.markdown-preview-view h4,
.markdown-source-view.mod-cm6 .HyperMD-header-4 {
    color: var(--text-title-h4);
    font-weight: 500;
}

.markdown-preview-view h5,
.markdown-source-view.mod-cm6 .HyperMD-header-5 {
    color: var(--text-title-h5);
    font-weight: 500;
}

.markdown-preview-view h6,
.markdown-source-view.mod-cm6 .HyperMD-header-6 {
    color: var(--text-title-h6);
    font-weight: 500;
}

/* Links */
.cm-hmd-internal-link,
.internal-link {
    color: var(--text-link);
    text-decoration: none;
}

.cm-hmd-internal-link:hover,
.internal-link:hover {
    color: var(--text-a-hover);
    text-decoration: underline;
}

/* Code blocks */
.markdown-preview-view code,
.cm-s-obsidian span.cm-inline-code {
    color: var(--text-normal);
    background-color: var(--inline-code-background);
    padding: 0.2em 0.4em;
    border-radius: 4px;
}

/* Blockquotes */
.markdown-preview-view blockquote,
.cm-s-obsidian .HyperMD-quote {
    border-left: 4px solid var(--blockquote-border);
    background-color: var(--blockquote-background);
    padding: 1em;
    margin: 1em 0;
    border-radius: 0 4px 4px 0;
}

/* Checkboxes */
input[type='checkbox'] {
    border: 1px solid var(--checkbox-border-color);
    background-color: transparent;
    transition: all 0.2s ease;
}

input[type='checkbox']:hover {
    border-color: var(--checkbox-border-color-hover);
    background-color: var(--checkbox-color-hover);
}

input[type='checkbox']:checked {
    background-color: var(--checkbox-color);
    border-color: var(--checkbox-color);
}

/* Tables */
th {
    background-color: var(--table-header-background);
    border-bottom: 2px solid var(--background-modifier-border);
    font-weight: 600;
}

tr:nth-child(even) {
    background-color: var(--background-secondary);
}

tr:hover {
    background-color: var(--table-row-background-hover);
}

/* Tags */
a.tag {
    color: var(--tag-color);
    background-color: var(--tag-background);
    padding: 2px 8px;
    border-radius: 4px;
    text-decoration: none;
    transition: all 0.2s ease;
}

a.tag:hover {
    background-color: var(--tag-background-hover);
    text-decoration: none;
}
