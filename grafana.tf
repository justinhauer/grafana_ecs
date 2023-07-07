resource "grafana_organization" "org_1" {
  name         = ""
  admin_user   = ""
  create_users = true
  admins = [
    "",
    ""
  ]
  # editors = [
  #   "editor-01@example.com",
  #   "editor-02@example.com"
  # ]
  #   viewers = [
  #     "viewer-01@example.com",
  #     "viewer-02@example.com"
  #   ]
}

resource "grafana_organization" "org_2" {
  name         = ""
  admin_user   = ""
  create_users = true
  admins = [
    "",
  ]
  editors = [
    ""
  ]
}

resource "grafana_user" "Rodney" {
  email    = ""
  name     = ""
  login    = ""
  password = ""
  is_admin = false
}