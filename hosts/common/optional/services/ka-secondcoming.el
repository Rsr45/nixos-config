;; urob's implementation of homerow converted to kanata by
;; https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/a_try_on_urobs_timeless_home_row_mods_for_kanata/

(defvar
  ;; variables for timings in ms using ZMK-like names
  tapping-term 300                       ;; A higher number allows for one handed modded keys reducing the chance of false-positives when typing fast
  quick-tap-ms 200                       ;; same as ZMK ($tap-repress-timeout in Kanata docs)
  require-prior-idle 250                 ;; same as ZMK (not used in vanilla kanata, but used as a workaround in this config)

  ;; keys for tap-hold-release-tap-keys-release templates
  left-side-keys   (q w e r t z x c v b) ;; these keys will always make the precedent same hand tap-hold-release-tap-keys-release output tap.
  home-row-left-keys  (a s d f g)      ;; home row mods + z for fn  - these will output a tap if they're released after the first key
  right-side-keys   (y u i o p m n) ;; these keys will always make the precedent same hand tap-hold-release-tap-keys-release output tap.
  home-row-right-keys  (; l k j h)      ;; home row mods + z for fn  - these will output a tap if they're released after the first key
  )

(deftemplate lhrm (tap-key hold-key) ;; these are home row mods for the left hand
             (tap-hold-release-tap-keys-release
              $quick-tap-ms
              $tapping-term
              (multi $tap-key @tap)
              $hold-key
              $left-side-keys
              $home-row-left-keys))

(deftemplate rhrm (tap-key hold-key) ;; these are home row mods for the right hand
             (tap-hold-release-tap-keys-release
              $quick-tap-ms
              $tapping-term
              (multi $tap-key @tap)
              $hold-key
              $right-side-keys
              $home-row-right-keys))

(defalias

  tap (multi
       (layer-switch nomods)
       (on-idle $require-prior-idle tap-virtualkey to-base)
       )

  a (t! lhrm   h lmet  )
  s (t! lhrm   i lalt   )
  d (t! lhrm   e lctrl   )
  f (t! lhrm   a lsft   )

  j (t! rhrm   a rsft   )
  k (t! rhrm   s rctrl  )
  l (t! rhrm   d ralt   )
  ; (t! rhrm   f rmet   ))

(defvirtualkeys
 to-base (layer-switch FGOuU))


(defsrc
 esc
 grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
 tab  q    w    e    r    t    y    u    i    o    p    [    ]    ret
 caps a    s    d    f    g    h    j    k    l    ;    '    \
 lsft <    z    x    c    v    b    n    m    ,    .    /    rsft
 lctl lmet lalt           spc                 ralt rmet menu rctl)

;; (deflayermap (turkishF)
;;              q f   w g   e g   r I   t o
;;              a u   s i   d e   f a   g U
;;              < j   z O   x v   c c   v C

;;              y d   u r   i n   o h   p p   [ q   ] w
;;              h t   j k   k m   l l   ; y   ' S   \ x
;;              n z   m s   , b   . .   / ,)

(deflayermap (FGOuU)
             q f   w g   e o   r u   t u
             a h   s i   d e   f a   g i
             < j   z w   x v   c c   v c

             y d   u r   i n   o rpt   p p   [ q   ] w
             h t   j k   k m   l l   ; y   ' s   \ x
             n z   m s   , b   . .   / ,
             spc (tap-hold 200 200 spc (layer-while-held spacefn)))

(deflayermap (nomods)
  q f  w g  e o  r u  t u       y d  u r  i n   p p  [ q ] w
  a h  s i  d e  f @f g i      h t  j @j  k m  l l  ; y ' s \ x  ;; shift keys are still here to except it from `require-prior-idle` timmings
  < j  z w  x v  c c  v c         n z  m s  , b  . .  / ,
)

(deflayermap (spacefn)
             q S-[   w S-]   e S-9   r S-0   t -
             a S-8   s S-6   d S-5   f S-4   g S-=
             < S-1   z S-7   x [     c ]     v S-;

             y d   u r   i n   o h   p p   [ q   ] w
             h t   j left   k down   l up   ; rght   ' s   \ x
             n z   m s   , b   . .   / ,)

;; keymap
(deflayermap (def)
          q q  w w  e e  r r  t t            y y u u i i o o p p
          a @a  s @s  d @d f @f  g g         h h j @j k @k l @l ; @;
          z z x x c c v v b b                n n  m m , , . . / /
          )
