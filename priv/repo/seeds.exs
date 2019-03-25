# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GuardianSpike.Repo.insert!(%GuardianSpike.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias GuardianSpike.Auth

{:ok, user} = Auth.create_user(%{first_name: "Bilbo", last_name: "Baggins", email: "bilbo@bagend.com", password: "inmypocketses"})
