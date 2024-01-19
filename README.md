# README

This is a practical exercise for Ophelos, the goal is to have a simple I&E statamente management app which also calculates the Disposable Expenditure and the I&E rating.


## How to run
This application was created using ruby `3.2.2`, `rails 7.1.3` and the default `sqlite` installed along with rais, after cloning the project and installing them, you can run `rails db:setup` to create the database and run the seeds with a simple sample data.

By running `rails server` and accessing `http://localhost:3000/` you'll be able to check the application on your browser.
To login you can use the sample created user (password: `12341234`, email: `test@test.mail.com`)

The project uses rubocop to ensure a pattern of code. To check it you can run rubocop (no offense should be displayed)

To run the automated test you might need to run `bundle exec rspec`, I quite sure `bundle exec` is required due to [this](https://github.com/ricsalvares/ie_statement/blob/main/Gemfile#L56) definition on the gem file.

## Project
The idea behind was to create isolated services to handle specific operations, trying to let them as much decoupled as possible. There are some tradeoffs though, among them is the decision of not using some rails built in functionalities such as validations and how the errors are handles/displayed (please check the "To be improved" section)

As it deals with money, my choice was to deal with it considering the amount values in pennies, using integer, [here](https://stackoverflow.com/questions/3730019/why-not-use-double-or-float-to-represent-currency#:~:text=Because%20floats%20and%20doubles%20cannot,times%20a%20power%20of%2010) there is an explanation.

### Files
I'm going to list some of the core files of this projects and what they do (or should do, please check more details on "To be improved" section)

#### app/models/services/create_statement.rb
This file controls the logic behind creating a statement and its statement items. It also calls other services to fulfil the `ie_rating` and `disposal_expenditure` attributes

#### app/models/services/update_statement.rb
The same as the previous one, it updates an existing statement, deletes the "marked to be deleted" statement items, creates newly added ones and updates the existing ones. It also calls the aforementioned services related to `ie_rating` and `disposal_expenditure`

#### app/models/services/calculate_disposable_income.rb
It calculates the disposal income of a given statement, it returns a hash containing the disposal_income amount and the income and expenditure sums, the last two are could be used by the next service in order to avoid recalculation  

#### app/models/services/calculate_ie_rating.rb
As mentioned before, this services calculates the I&E rating according to the income and expenditure amounts provided.

## To be improved
As mentioned previously, this is a section to list some improvement to be done to this project.

#### Error Handling
The errors aren't being raised/rescued properly, in fact I just used `ActiveRecord::RecordInvalid` a few times on the services used to persist data. Clearly other errors could be defined, raised and rescued properly

#### Validations
More validations could take place before persisting data within the services.

#### Queries
For both update and create records sometimes I use `statement.statement_items.build` before persisting it. This item and the previous 2 are related, having better validations, which occasionally raise specific errors could avoid such code, which implies 1 insert for each `statement_item` built. One maner to improve it would be having a bulk insert `MODEL.insert_all`

#### Ui/Ux
I think it is self-explanatory, specificaly speaking about how to delete `statement_items`. The dropdown wasn't the best choice, but it saved me time. A link (with icon, perhaps) to mark the items to be deleted AND hide them from the UI would improve the User experience a lot.

#### View files
Perhaps the files related to the views could be refactored in order to avoid DRY and surely improve the readability and maintanability.

#### Specs and coverage
Fot most services/models I used TDD and, therefore the specs are indispensable, however most time I've thought on the happy paths and even when I did something considering some failures scenarios I didn't go further on that. That's why I point it as a thing to be improved. To be honest I didn't check the coverage of specs, but again, a thing to be improved.

#### Use of a specific gem to manage the value in pennies properly
As pointed previously, I've opted to use full amount of pennies to handle with moneys values (`disposable_income_pennies`, `amount_pennies`), which honestly took some effort to handle it, by adding a specific gem could save time and avoid some manual treatment for it (such as `fdiv` calls throught the code).

#### Authentication
I used `devise` to managed it, by just following the "get started" steps, this could be revisited in order to be configured properly.

## Disclaimer
Perhaps there are more things to be improved, especially related (but not limited) to the UI but those above are those I think would have priority to be attacked.



