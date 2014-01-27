HTML500 Site Publisher & Presenter
=======

## Installation

1. clone
2. `bundle`
3. `touch .env`
4. append following contents to `.env`
    
    SESSION_KEY=somerandomstring
    DATABASE_URL=sqlite3:///db/dev.db

5. `rake db:migrate`
6. `shotgun`

