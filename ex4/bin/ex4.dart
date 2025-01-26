class employee{
  int employeeId;
  String name;
  String role;
  String location;

  employee(this.employeeId, this.name, this.role, this.location);

  static void display(List<employee> EmployeeList, Map<String, int> salaryMap, int minSalary){
    print("Employees with salary greater than INR ${minSalary} Lakhs are as follows");
    print("-------------------------------------------------------------");
    for(var employee in EmployeeList){
      int? salary = salaryMap[employee.role];
      if(salary != null && salary > minSalary){
        print("employeeId is ${employee.employeeId}");
        print("name is ${employee.name}");
        print("role is ${employee.role}");
        print("location is ${employee.location}");
        print("-------------------------------------------------------------");
      }
    }
  }
}

void main(){

  List<employee> EmployeeList = [
    employee(001, 'Hari Krishnan', 'HR', 'Bengluru'),
    employee(002, 'Amal Krishnan', 'Manager', 'Kochi'),
    employee(003, 'Sourav Satheesh', 'Senior Consultant', 'Hydrebad'),
    employee(004, 'Pranav P', 'HR', 'Kochi'),
    employee(005, 'Joel Samuel', 'Junior Clerk', 'Thiruvanathapuram'),
    employee(006, 'Jacob Cherian', 'Junior Clerk', 'Kochi'),
    employee(007, 'Nabeel Mustafa', 'HR', 'Thiruvanathapuram'),
    employee(008, 'John Abraham', 'CEO', 'Kochi'),
    employee(009, 'Joseph Mangootathil', 'Data Analyst', 'Chennai'),
    employee(010, 'Febin Nelson', 'Backend Developer', 'Bengluru'),
  ];

  Map<String, int> salaryMap = {
    'HR' : 33334,
    'Manager' : 125375,
    'Senior Consultant' : 166667,
    'Junior Clerk' : 19900,
    'CEO' : 233334,
    'Data Analyst' : 15000,
    'Backend Developer': 66667
  };

  employee.display(EmployeeList, salaryMap, 200000);
}

