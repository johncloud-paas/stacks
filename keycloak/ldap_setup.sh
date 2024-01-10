#! /bin/sh

dsconf -v localhost backend create --suffix dc=johncloud,dc=fr --be-name johncloud --create-suffix

ldapadd -v -H ldap://keycloak-ldap-1:3389/ -x -W -D "cn=Directory Manager" << EOF
dn: ou=People,dc=johncloud,dc=fr
objectClass: top
objectClass: organizationalUnit
ou: People
EOF

dsconf -v localhost -D "cn=Directory Manager" plugin memberof enable

dsconf -v localhost -D "cn=Directory Manager" config replace nsslapd-allow-anonymous-access=off

ldapadd -v -H ldap://keycloak-ldap-1:3389/ -x -W -D "cn=Directory Manager" << EOF
dn: ou=Administrators,dc=johncloud,dc=fr
objectClass: top
objectClass: organizationalUnit
ou: Administrators
EOF

ldapadd -v -H ldap://keycloak-ldap-1:3389/ -x -W -D "cn=Directory Manager" << EOF
dn: uid=admin,ou=Administrators,dc=johncloud,dc=fr
cn: admin
sn: admin
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetOrgPerson
userPassword: test
EOF

ldapmodify -v -H ldap://keycloak-ldap-1:3389/ -x -W -D "cn=Directory Manager" << EOF
dn: dc=johncloud,dc=fr
changetype: modify
add: aci
aci: (target="ldap:///dc=johncloud,dc=fr")(targetattr="*") (version 3.0; acl "johncloud"; allow (search,read,compare) userdn="ldap:///uid=admin,ou=Administrators,dc=johncloud,dc=fr";)
EOF
