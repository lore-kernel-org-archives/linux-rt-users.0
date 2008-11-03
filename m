From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: nohz=off
Date: Mon, 03 Nov 2008 17:48:41 +0000
Message-ID: <1225734521.14192.5.camel@segulix.localdomain>
References: <1225729643.10570.6.camel@segulix.localdomain>
	 <20081103170234.GC19329@unix.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-y3PLn2JhgWXkbj5AE6TB"
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:60042 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750978AbYKCRtF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Nov 2008 12:49:05 -0500
In-Reply-To: <20081103170234.GC19329@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-y3PLn2JhgWXkbj5AE6TB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon, 2008-11-03 at 15:02 -0200, Luis Claudio R. Goncalves wrote:
> On Mon, Nov 03, 2008 at 04:27:23PM +0000, Sergio Monteiro Basto wrote:
> | Hi,=20
> | When I have to boot with nohz=3Doff , this could be a problem with rt
> | isn't it ?=20
>=20
> I am not sure I understood your question but it is not a problem to use
> RT with NOHZ disabled. I even dare to say that most distributions ship wi=
th
> NOHZ disabled by default.
>=20

Hi, to laptop not hang on boot with a kernel 2.6.24 until a kernel
2.6.27, I need put on boot options, nohz=3Doff , and this seems the bigger
problem .=20
How I find out / debug what happen on my laptop with nohz ?=20

Thanks,=20

> Luis
>=20
> | Who I could debug this problem ?=20
> | This is a laptop with linux x86_64 ( I had try fedora 10 beta ) and
> | others kernel like 2.6.22 and 2.6.24 .
> |
> | Can you point me some documentation about nohz=3Doff ,=20
> | I try search a bit but don't found anything interesting.
> |=20
> | Thanks, =20
> | --=20
> | S=C3=A9rgio M. B.
>=20
>=20
> ---end quoted text---
>=20
--=20
S=C3=A9rgio M. B.

--=-y3PLn2JhgWXkbj5AE6TB
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGVjCCAw8w
ggJ4oAMCAQICEA6CVh3keQ8TFtyrh/wrbgYwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MTAxNDAzMTc0N1oXDTA5MTAxNDAzMTc0
N1owSzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZc2Vy
Z2lvQHNlcmdpb21iLm5vLWlwLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ2D
rpizYnrRUFYQm6b6ZcE50ta36mutS13FIAqg0ugCjlSFSv+nkjbfEBOug+hb5vh9SOBOLy+UFJrn
2MibIuLGip4OsawcJ41Z7prkKlUCIwtNLmb/m7swubSLqFRiojy0ctMhMWtDt9xzwOYmZN7yGMiS
jFHivrtZRGPWA7tPzN3KOQeSP4DYxLZ06a3ZOwqR4g3NkQeWbdLVvBe6r3mKtaoDeirW5XT8epyh
vqRK7izl/vOum2Gx+HeaLpyH5pTOhMd2K7DTfMiBjqBxchUDTccOykMN+5i9ketxy3Bh0PfEStZh
vjaZbCsJIV2WQc/jAH+k3xef41fci2o+Cz0CAwEAAaNZMFcwDgYDVR0PAQH/BAQDAgSQMBEGCWCG
SAGG+EIBAQQEAwIFoDAkBgNVHREEHTAbgRlzZXJnaW9Ac2VyZ2lvbWIubm8taXAub3JnMAwGA1Ud
EwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAABP+jrmaOnO/2yM7OeJmjEVjDJpT2baLpvBL1k4O
6HSVgsx5JidSa+vF/cKaP1UFko8XT2TooDpnrTbw//Rkfd6ZbeXXqzdIJQs4xiSRGgcMuJL8GtuH
LQHkOIqKaPW+KSzVG68U/NzSzqdtr5iPwE6YCLMN0WnVduhgLQlXqkAwggM/MIICqKADAgECAgEN
MA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9D
ZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20w
HhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZ
Wh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuv
PAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBly
YLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRw
Oi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMC
AQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFh
YsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVN
d+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIB/DCCAfgCAQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECEA6CVh3keQ8TFtyrh/wrbgYwCQYFKw4DAhoFAKBdMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MTEwMzE3NDg0MVowIwYJKoZI
hvcNAQkEMRYEFOHA6+JOYpBb4COp+2n7R1dRoIv3MA0GCSqGSIb3DQEBAQUABIIBACDgQhaNCCNV
F4oxMkdAy/SrCyxHSphq4WG1Qaw61aFUqgw1HPDvA/d5+XpfxqlbpYgmt6+rdJ+5wRsRI4WZLaus
QCiMCvhHON9ms7g8AW6H0OeFmd1EF6vxUJf2jpL2JKrB/AbqlhbFdCdTrrLocKqB5sv/ayoYSmq4
ZZn+lZUr0PZ4S8Xd7gZqN2uSG6Of5A7rBFif1WXYlx6ysVJnwrjHhPXeG0H5MCmkWkaUy9wpywSm
51wdAHJFcg6ZRNYoCIeye8ORR9EjLt3Rf4pNBdv2MCQQLqzlCJQBiGkH3NZerERmHaAhMfvkY29y
k8BvgsxlxcDTyxdiaMxxvajc6cYAAAAAAAA=


--=-y3PLn2JhgWXkbj5AE6TB--

