job_sub     = ['Maths','English','Art']
job_branch  = ['ECE','MECH','BCOM']
pass_mark_cutoff        = 35
qualify_mark_cutoff     = 90
math_account_mark_cuttoff = 95
applicant_job_mark_list = []

try:
    applicant_name = input("Enter your name : ")
    applicant_branch_priority = input(f"Input your branch priority {job_branch} :")
    
    sub_pref = input(f"Input Subject Preference (1 or more  comma-separated, High to Low Priority){job_sub}: ")
    applicant_sub_pref = sub_pref.split(',')
        
    marks = input(f"Input marks (comma-separated, order of Mark: ){job_sub}: ")
    applicant_job_mark_list =  [int(x) for x in marks.split(',')]
    if len(applicant_job_mark_list) != 3:
        raise ValueError("Marks input should contain exactly 3 integers.")
            
except ValueError as e:
    print(f"Please provide valid inputs. Error: {e}")

applicant_job_mark = dict(zip(job_sub,applicant_job_mark_list))             #List to Dic convertion

print("Name : " ,applicant_name)
print("Branch Prefernce:", applicant_branch_priority)
print("Subject Prefernce :", applicant_sub_pref)
print("Marks:", applicant_job_mark)

all_passed  = (applicant_job_mark.get('Maths', 0) > pass_mark_cutoff) and (applicant_job_mark.get('English', 0) > pass_mark_cutoff) and \
                (applicant_job_mark.get('Art', 0) > pass_mark_cutoff)
marketing   = (applicant_job_mark.get('English', 0) > qualify_mark_cutoff) and (applicant_job_mark.get('Art', 0) > qualify_mark_cutoff)
account     = (applicant_job_mark.get('Maths', 0) > math_account_mark_cuttoff) 
sales       = (applicant_job_mark.get('Maths', 0) > qualify_mark_cutoff) and (applicant_job_mark.get('English', 0) > qualify_mark_cutoff)

if( all_passed ):
    if( marketing or account or sales):
        print("Job Available in")
        if(marketing):
            print("Marketing")
        if(account):
            print("Account")
        if(sales):
            print("Sales")
    else:
        print("No Opening in provided criteria.")  
else:
    print("Not  Passed for all subject.")