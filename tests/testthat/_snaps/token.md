# test token

    Code
      set_token("hackme")
    Message
      v Token stored for the session.

---

    Code
      forget_token()
    Message
      v Token has been unset.

---

    Code
      set_token("!")
    Message
      ! The token may not have the right format.
      v Token stored for the session.

---

    Code
      set_token(old)
    Message
      v Token stored for the session.

