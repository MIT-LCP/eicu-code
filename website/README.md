# Website and documentation for the eICU Collaborative Research Database

## Instructions for running the website locally

1. Install Go and Hugo. For instructions, see: http://gohugo.io/overview/installing/. Since the Hugo version on the server is v0.74.3, best install the same version when testing locally. Using newer version might generate errors in building the website. 

2. Clone the website repository:
   ```
   git clone https://github.com/MIT-eicu/eicu-code.git
   ```
3. Change to the "website" directory
4. Run ```hugo server``` at the command line to build the website and serve the pages;

## Update website 

1. Fork eicu-code repository to your own GitHub space if you are not owner of the oringal MIT-LCP/eicu-code repo. 

2. Create a new branch and make change locally. 

3. After testing the website, make a pull request on MIT-LCP/eicu-code repo. 


## Deployment of the website
(For LCP lab members only)

1. Add eicu-website to remote
   After the pull request of the new material is merged into the main branch of eicu-code, pull down the latest version of "main" branch to your local repo. And then run the following command locally. 
 
   `git remote add eicu-website webuser@<IP address>:/home/webuser/eicu-website.git`
 
   * Optional: Check if the command above ran correctly,
   Run command: `git remote -v`
   should return:
   eicu-website webuser@<IP address>:/home/webuser/eicu-website.git (fetch)
   eicu-website webuser@<1IP address>:/home/webuser/eicu-website.git (push)
   origin   https://www.github.com/MIT-LCP/eicu-code (fetch)
   origin   https://www.github.com/MIT-LCP/eicu-code (push)
 
2. Sshuttle into the production server
 (Skip if you are within the LCP secure network)
 
   Run the following command after filling in the  LCP username: `alias sshholyoke="sshuttle -r <Username>helios.mit.edu <IP address, replace last section with 0/24>"`
 
   Run command: `sshholyoke`
 
   Should return:  “client: Connected” after you enter your password
 
3. Push development
 
   In another terminal from your mimic-website repo:
 
   Run command: `git push eicu-website`

   * Note:
   Your public key (for the machine you're pushing from) must be in the webuser group

