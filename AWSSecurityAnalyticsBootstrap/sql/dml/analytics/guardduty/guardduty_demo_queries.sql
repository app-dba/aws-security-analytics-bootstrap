/*Example – DNS data exfiltration

The following query returns information about Amazon EC2 instances that might be exfiltrating data through DNS queries. */

SELECT
    title,
    severity,
    type,
    id AS FindingID,
    accountid,
    region,
    createdate,
    updatedate,
    json_extract_scalar(service, '$.count') AS Count,
    json_extract_scalar(resource, '$.instancedetails.instanceid') AS InstanceID,
    json_extract_scalar(service, '$.action.actiontype') AS DNS_ActionType,
    json_extract_scalar(service, '$.action.dnsrequestaction.domain') AS DomainName,
    json_extract_scalar(service, '$.action.dnsrequestaction.protocol') AS protocol,
    json_extract_scalar(service, '$.action.dnsrequestaction.blocked') AS blocked
FROM gd_logs
WHERE type = 'Trojan:EC2/DNSDataExfiltration'
ORDER BY severity DESC

/*Example – Unauthorized IAM user access

The following query returns all UnauthorizedAccess:IAMUser finding types for an IAM Principal from all regions. */

SELECT title,
         severity,
         type,
         id,
         accountid,
         region,
         createdate,
         updatedate,
         json_extract_scalar(service, '$.count') AS Count, 
         json_extract_scalar(resource, '$.accesskeydetails.username') AS IAMPrincipal, 
         json_extract_scalar(service,'$.action.awsapicallaction.api') AS APIActionCalled
FROM gd_logs
WHERE type LIKE '%UnauthorizedAccess:IAMUser%' 
ORDER BY severity desc;