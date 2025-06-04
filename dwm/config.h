/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "FiraCode Nerd Font:size=16" };
static const char dmenufont[]       = "Jetbrains mono Nerd Font:size=10";
static const char col_mauve[]     = "#313244"; // Mauve (helles Lila)
static const char col_bluegray[]  = "#3B4261"; // Blau-grau für ausgewählten Tag (Workspace)
static const char col_white[]     = "#FFFFFF"; // Weiß für fokussierte Fensterborder
static const char col_bg[]        = "#1E1E2E"; // Dunkler Hintergrund (Bar)
static const char col_fg[]        = "#D9E0EE"; // Helle Schrift (Text)
static const char col_bordernorm[]= "#414559"; // Normale Fensterborder (dunkles Grau)
static const unsigned int gappx = 10;  // gaps between windows
static const char *colors[][3] = {
    /*               fg          bg           border       */
    [SchemeNorm] = { col_fg,     col_bg,      col_bordernorm },
    [SchemeSel]  = { col_fg,     col_bluegray, col_white    },
};



static const char *const autostart[] = {
    "xset", "s", "off", NULL,
    "xset", "s", "noblank", NULL,
    "xset", "-dpms", NULL,  
    "picom", NULL,
    "dunst", NULL,
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1", NULL,
    "autorandr", "--change", NULL,
    "slstatus", NULL,
    "feh", "--bg-scale", "/home/chef/Pictures/Arch.jpg", NULL,
    NULL /* Ende */
};


/* tagging */
static const char *tags[] = { " ", " ", " ", " ", " "};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = { "kitty", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_space,    spawn,        {.v = dmenucmd } },
	{ MODKEY,                       XK_z,        spawn,        {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_q,        quit,         {0} },
  { MODKEY,                       XK_q,        killclient,   {0} },
  { MODKEY,                       XK_Left,     focusstack,   {.i = -1 } },  // Vorheriges Fenster
  { MODKEY,                       XK_Right,    focusstack,   {.i = +1 } },  // Nächstes Fenster
  { MODKEY,                       XK_Up,       focusstack,   {.i = -1 } },  // Vorheriges Fenster (alternativ)
  { MODKEY,                       XK_Down,     focusstack,   {.i = +1 } },  // Nächstes Fenster (alternativ)

/* MODKEY + number: switch to tag */
{ MODKEY,                       XK_1,      view,           {.ui = 1 << 0} },
{ MODKEY,                       XK_2,      view,           {.ui = 1 << 1} },
{ MODKEY,                       XK_3,      view,           {.ui = 1 << 2} },
{ MODKEY,                       XK_4,      view,           {.ui = 1 << 3} },
{ MODKEY,                       XK_5,      view,           {.ui = 1 << 4} },
/* MODKEY + Shift + number: move focused window to tag */
{ MODKEY|ShiftMask,             XK_1,      tag,            {.ui = 1 << 0} },
{ MODKEY|ShiftMask,             XK_2,      tag,            {.ui = 1 << 1} },
{ MODKEY|ShiftMask,             XK_3,      tag,            {.ui = 1 << 2} },
{ MODKEY|ShiftMask,             XK_4,      tag,            {.ui = 1 << 3} },
{ MODKEY|ShiftMask,             XK_5,      tag,            {.ui = 1 << 4} },


  { MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
  { MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
  { MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },



  };

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

