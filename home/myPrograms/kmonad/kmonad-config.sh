kbd_device=`find /dev/input/by-path/*event-kbd | head -n 1`

cat << EOF > config.kbd
(defcfg
  input  (device-file "$kbd_device")
  output (uinput-sink "kmonad configuration file")

  fallthrough true

  allow-cmd false
)

(defsrc
  grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab   q    w    e    r    t    y    u    i    o    p    [    ]    ret
  caps  a    s    d    f    g    h    j    k    l    ;    '    \\
  lsft 102d  z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt            spc                 ralt rmet cmp  rctl
)

(defalias
  nav  (layer-toggle navigation)
  sym  (layer-toggle symbols)

  lws  C-A-left
  rws  C-A-rght
  lbt  RA-8
  rbt  RA-9
  lbe  RA-7
  rbe  RA-0
  lpr  #(S-8 P1)
  rpr  #(S-9 P1)
  til  RA-]
  at   RA-q
  hsh  RA-3
  dol  RA-4
  prc  S-5
  amp  S-6
  quo  grv
  squ  S-2
  qm   S--
  em   S-1
  equ  S-0
  crt  S-3
  pls  S-4
  ast  -
  bsl  RA--
  fsl  S-7
  lt   #(102d P1)
  gt   #(S-102d P1)
  pip  RA-=
  btk  RA-\\
  mnu  S-f10
)

(deflayer qwerty
  _     _    _    _    _    _    _    _    _    _    _    _    _    _
  _     _    _    _    _    _    _    _    _    _    _    _    _    _
  @nav  _    _    _    _    _    _    _    _    _    '    ;    .
  _     =    _    _    _    _    _    _    _    _    \\    _    _
  _     _    _              _              @sym _    _    _
)

(deflayer navigation
  _     _    _    _    _    _    _    _    _    _    _    _    _    _
  _     esc  _    _    _    _    @til home up   end  pgup _    _    _
  _     _    _    @lws @rws _    @lbt left down rght pgdn _    _
  _     _    _    _    caps @mnu _    @rbt @lbe @lpr @rpr @rbe _
  _     _    _              _              _    _    _    _
)

(deflayer symbols
  _     _    @btk @lt  @gt  _    _    _    _    _    _    _    _    _
  _     @at  @hsh @dol @prc @amp _    _    _    _    _    _    _    _
  _     @quo @qm  @equ @pls @fsl _    _    _    _    _    _    _
  _     @pip @squ @em  @crt @ast @bsl _    _    _    _    _    _
  _     _    _              _              _    _    _    _
)

EOF
