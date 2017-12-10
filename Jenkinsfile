pipeline {
  agent any
  stages {
    stage('Test Script') {
      steps {
        sh 'cd cookbooks/ && foodcritic ror-app/'
        sh 'cd cookbooks/ror-app/ && chef exec rspec  spec/unit/recipes/default_spec.rb'
      }
    }
     stage('Create nodes') {
      steps {
        sh 'cd cookbooks/ror-app/ && kitchen create && kitchen converge'
      }
    }
     stage('Verify nodes') {
      steps {
        sh 'cd cookbooks/ror-app/ && kitchen verify'
      }
    }
     stage('Verify nodes') {
      steps {
        sh 'cd cookbooks/ror-app/ && kitchen destroy'
      }
    }
     stage('Create and upload cookbook') {
      steps {
        sh 'cd cookbooks/ror-app/ && berks install && berks upload'
      }
    }
     stage('bootstrap') {
      steps {
        sh 'knife bootstrap 34.201.33.196 --ssh-user ubuntu --sudo --identity-file /opt/keys/coupa.pem --node-name node1-test2 --run-list 'recipe[ror-app]' -y"'
      }
    }
     stage('test') {
      steps {
        sh 'ssh -i /opt/keys/coupa.pem ubuntu@34.201.33.196 "rake spec"'
      }
    }
  }
}
