# test token

    Code
      set_token("hackme")
    Message <cliMessage>
      v Token stored for the session.

---

    Code
      forget_token()
    Message <cliMessage>
      v Token has been unset.

---

    Code
      set_token("!")
    Message <cliMessage>
      ! The token may not have the right format.
      v Token stored for the session.

