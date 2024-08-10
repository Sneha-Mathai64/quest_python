class Applicant:
    def __init__(self, job_sub, job_branch, pass_mark_cutoff, qualify_mark_cutoff, math_account_mark_cutoff):
        self.job_sub = job_sub
        self.job_branch = job_branch
        self.pass_mark_cutoff = pass_mark_cutoff
        self.qualify_mark_cutoff = qualify_mark_cutoff
        self.math_account_mark_cutoff = math_account_mark_cutoff
        self.applicant_job_mark_list = []
        self.applicant_name = ""
        self.applicant_branch_priority = ""
        self.applicant_sub_pref = []
        self.applicant_job_mark = {}

    def get_input(self):
        while True:
            try:
                self.applicant_name = input("Enter your name: ")
                self.applicant_branch_priority = input(f"Input your branch priority {self.job_branch}: ")
                
                sub_pref = input(f"Input Subject Preference (1 or more, comma-separated, High to Low Priority) {self.job_sub}: ")
                self.applicant_sub_pref = sub_pref.split(',')
                
                marks = input(f"Input marks (comma-separated, order of Mark: {self.job_sub}): ")
                self.applicant_job_mark_list = [int(x) for x in marks.split(',')]
                if len(self.applicant_job_mark_list) != 3:
                    raise ValueError("Marks input should contain exactly 3 integers.")
                break  # Exit the loop if everything is valid
            except ValueError as e:
                print(f"Please provide valid inputs. Error: {e}")
                print("Let's try again.\n")

        self.applicant_job_mark = dict(zip(self.job_sub, self.applicant_job_mark_list))  # List to dictionary conversion

    def display_applicant_details(self):
        print("\nApplicant Details:")
        print("Name:", self.applicant_name)
        print("Branch Preference:", self.applicant_branch_priority)
        print("Subject Preference:", self.applicant_sub_pref)
        print("Marks:", self.applicant_job_mark)

    def check_eligibility(self):
        all_passed = (
            self.applicant_job_mark.get('Maths', 0) > self.pass_mark_cutoff and 
            self.applicant_job_mark.get('English', 0) > self.pass_mark_cutoff and 
            self.applicant_job_mark.get('Art', 0) > self.pass_mark_cutoff
        )

        marketing = (
            self.applicant_job_mark.get('English', 0) > self.qualify_mark_cutoff and 
            self.applicant_job_mark.get('Art', 0) > self.qualify_mark_cutoff
        )

        account = (
            self.applicant_job_mark.get('Maths', 0) > self.math_account_mark_cutoff
        )

        sales = (
            self.applicant_job_mark.get('Maths', 0) > self.qualify_mark_cutoff and 
            self.applicant_job_mark.get('English', 0) > self.qualify_mark_cutoff
        )

        return all_passed, marketing, account, sales

    def display_job_availability(self, all_passed, marketing, account, sales):
        if all_passed:
            if marketing or account or sales:
                print("\nJob Available in:")
                if marketing:
                    print("- Marketing")
                if account:
                    print("- Account")
                if sales:
                    print("- Sales")
            else:
                print("\nNo openings in the provided criteria.")
        else:
            print("\nNot passed in all subjects.")


job_sub = ['Maths', 'English', 'Art']
job_branch = ['ECE', 'MECH', 'BCOM']
pass_mark_cutoff = 35
qualify_mark_cutoff = 90
math_account_mark_cutoff = 95

applicant = Applicant(job_sub, job_branch, pass_mark_cutoff, qualify_mark_cutoff, math_account_mark_cutoff)

# Get input from the user
applicant.get_input()

# Display applicant details
applicant.display_applicant_details()

# Check eligibility for jobs
all_passed, marketing, account, sales = applicant.check_eligibility()

# Display job availability
applicant.display_job_availability(all_passed, marketing, account, sales)
