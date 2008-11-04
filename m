From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: nohz=off
Date: Tue, 04 Nov 2008 20:43:13 +0000
Message-ID: <1225831393.17757.9.camel@segulix.localdomain>
References: <1225729643.10570.6.camel@segulix.localdomain>
	 <20081103170234.GC19329@unix.sh>
	 <1225811449.30849.2.camel@segulix.localdomain>
	 <20081104194652.GN19329@unix.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-Mu9oUXEZC1xFMjUSavca"
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:49812 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752765AbYKDUnS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Nov 2008 15:43:18 -0500
In-Reply-To: <20081104194652.GN19329@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-Mu9oUXEZC1xFMjUSavca
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tue, 2008-11-04 at 17:46 -0200, Luis Claudio R. Goncalves wrote:
> On Tue, Nov 04, 2008 at 03:10:48PM +0000, Sergio Monteiro Basto wrote:
> |=20
> | On Mon, 2008-11-03 at 15:02 -0200, Luis Claudio R. Goncalves wrote:
> | > it is not a problem to use
> | > RT with NOHZ disabled.
> |=20
> | Well but when NOHZ is enable and laptop hang on boot , this problem
> | should be reported here ?=20
>=20
> Sure thing.
>=20
> But it is usually important to add all the relevant information you have
> available. Exact kernel version, any special config option you used when
> compiling the kernel, any error message printed during boot, the last
> message printed before the system froze, etc...
>=20
> It is hard to help debugging a problem without information.

OK , I don't have laptop here, next weekend I can send dmesg , lspci
dmidecode etc .=20
I test with Fedora-10-Live-Beta-x86_64,
kernel-2.6.27-0.352.rc7.git1.fc10=20

and a Fedora 9 updated kernel with kernel kernel-2.6.26.5-45.fc9.i686

test with others kernel from Mandriva .=20


but my initial question is: where I can find more documentation , for
trying debug this problem ? debug boot parameters , etc=20

Thanks,=20
>=20
> Regards,
> Luis
--=20
S=C3=A9rgio M. B.

--=-Mu9oUXEZC1xFMjUSavca
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MTEwNDIwNDMwOVowIwYJKoZI
hvcNAQkEMRYEFD94IFVAeZ8paGlRqAhnMwzq9jvTMA0GCSqGSIb3DQEBAQUABIIBAFYAswHEGYsF
mO3g2/GLCOj+gz8NB8oLyHWFuHtwUEcHoAsDv0IVYk1+hXyre958ylmWaWKO8/qi8juSzM0Z+zO0
EbMSwrmbNvVJVOL6iPdSrqCBZqfni4hdzeAkwmlmUK3JxHm9egaeyFt4XhsgO/DqAAq7c6dRcQrT
YjYzJgy0703JoD2WLqyNVFr2BJZi5YgOnEWp5lQ6b7EcHsUWdJL/xIT9hjmEAJCLsQWAKGtWAW+h
TbbMhgGt9oOrrLiWL7d7e2BKNBfh6MkkN+hwSm6p7G4DWIC3VxY7HXuUl5OuoOXk+o23wD6jblR3
O/Itv0aHCQDdb1oo0wg1FvFT3s4AAAAAAAA=


--=-Mu9oUXEZC1xFMjUSavca--

