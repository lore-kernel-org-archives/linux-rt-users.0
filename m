From: Dave Rolenc <drolenc@rtlogic.com>
Subject: RE: Eliminating Packet Latency
Date: Tue, 15 Mar 2016 17:24:47 +0000
Message-ID: <DF8A1D73F1EFD14E8EC020CD95DD8F649955240F@sd-mb01.wfinet.com>
References: <262920A1-2716-4D46-9A0F-7E7DC93EE24D@aha.com>
 <56E7CE1F.9010301@meduna.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_00CD_01D17EAD.47633120"
Cc: Dave Rolenc <drolenc@rtlogic.com>
To: Stanislav Meduna <stano@meduna.org>,
	Michael Hewitt <mhewitt@aha.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-001f5801.pphosted.com ([148.163.157.244]:8246 "EHLO
	mx0a-001f5801.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbcCOR6w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Mar 2016 13:58:52 -0400
In-Reply-To: <56E7CE1F.9010301@meduna.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

------=_NextPart_000_00CD_01D17EAD.47633120
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Michael,

You can try this. The 3.10.0 code looked a little different, but this is the
gist of what I did on the older code. This is untested, so you are on the
hook for that part. I don't even know if this compiles, but it should:

--- linux-3.10.old/net/core/dev.c       2016-03-15 10:57:11.399668975 -0600
+++ linux-3.10/net/core/dev.c   2016-03-15 11:14:58.566734817 -0600
@@ -2675,28 +2675,6 @@
        if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
                kfree_skb(skb);
                rc = NET_XMIT_DROP;
-       } else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
-                  qdisc_run_begin(q)) {
-               /*
-                * This is a work-conserving queue; there are no old skbs
-                * waiting to be sent out; and the qdisc is not running -
-                * xmit the skb directly.
-                */
-               if (!(dev->priv_flags & IFF_XMIT_DST_RELEASE))
-                       skb_dst_force(skb);
-
-               qdisc_bstats_update(q, skb);
-
-               if (sch_direct_xmit(skb, q, dev, txq, root_lock)) {
-                       if (unlikely(contended)) {
-                               spin_unlock(&q->busylock);
-                               contended = false;
-                       }
-                       __qdisc_run(q);
-               } else
-                       qdisc_run_end(q);
-
-               rc = NET_XMIT_SUCCESS;
        } else {
                skb_dst_force(skb);
                rc = q->enqueue(skb, q) & NET_XMIT_MASK;
@@ -2705,7 +2683,8 @@
                                spin_unlock(&q->busylock);
                                contended = false;
                        }
-                       __qdisc_run(q);
+            __netif_schedule(q);
+            qdisc_run_end(q);
                }
        }
        spin_unlock(root_lock);

Dave

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org
[mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Stanislav Meduna
Sent: Tuesday, March 15, 2016 2:56 AM
To: Michael Hewitt; linux-rt-users@vger.kernel.org
Subject: Re: Eliminating Packet Latency

On 3/14/2016 10:02 PM, Michael Hewitt wrote:

> Generally, we see packet delivery variations of less than 100 
> microseconds, which is fabulous.  Occasionally, we see a packet 
> delivery delay in excess of 1000 microseconds.

Maybe this thread applies
http://www.spinics.net/lists/linux-rt-users/msg09887.html
(no straightforward solution there though).

-- 
                                 Stano

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_00CD_01D17EAD.47633120
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIRmzCCBdEw
ggS5oAMCAQICEDY3A2GiKK2QlGjtkqwuGpMwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdC
MRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoT
EUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE0MTAwMjAwMDAwMFoXDTE2MTAwMTIzNTk1OVow
gdkxFTATBgNVBBQTDDcxOS01OTgtMjgwMTEOMAwGA1UEERMFODA5MjExHjAcBgNVBAoTFVJlYWwg
VGltZSBMb2dpYywgSW5jLjEhMB8GA1UECRMYMTI1MTUgQWNhZGVteSBSaWRnZSBWaWV3MQswCQYD
VQQIEwJDTzEZMBcGA1UEBxMQQ29sb3JhZG8gU3ByaW5nczELMAkGA1UEBhMCVVMxFDASBgNVBAMT
C0RhdmUgUm9sZW5jMSIwIAYJKoZIhvcNAQkBFhNkcm9sZW5jQHJ0bG9naWMuY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6I4Is9m4J+9GPyiaKw2y2nE0T1qgxUIULzL8Ed5OFsy7
pZnhyTfF8dPBCTK1p/KkFYjfKvvl+x5dDBcAyv+Jafjt3EDtz5bs8tkSLTts/57X5GYMTLqqqVCi
UpsyFnpNK/PUStTH2EIgUEfalMbC2fagTBe7/zxGXTJ2s40bhHv7vOi1KAGfJpgWbkmuQqSUBdRm
4Fb0l0TIswuDKFGg6IMTLLDfidj2NITy7VSw2xe7GaX8Is6x0dHVrWFaJxbsdGEn7Do0Y1WEtO8G
aktRAPXzcEZ83mtbStjYs6Hl4Q70uF/SGHn8O4L9nKJnsWl1L+xVHPEdxjcklB6sCVQtfQIDAQAB
o4IB0zCCAc8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFCk69XFp
o8zgOW2bfaucL6NSplF0MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQG
CCsGAQUFBwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUF
BwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRw
Oi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5j
cnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkcm9s
ZW5jQHJ0bG9naWMuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQAhEgGZviiTqI0Mb44ZU0Ttg02zh2ot
ptldz5IYvxByg9ckG3SB35mlpwo+NVW7t6hRRZ0+CaGvSOiERbqx3fsApG67d1BBkczuQQ4VE0aI
V2z6vT/pCs19IpRjFtLUqx2kzv2kIhXbXhXzJTos5qN6F6pwCKazc9j5zdvTrf5hEBXHyZxgWgOb
RwVPpiIXu1bAPPxPpHtRwIiT/w53WMc7W9kDd8KLUuYXNt8/rb47zFCmpbBKM+Xo8ycMe9oWBveW
71+gpfa9fg/mDUDj666hmEvkAEdNDPFmStqIdlejmC/xDK/ueOQh8g3WL1rfNFqPmAQpwIOyK+jT
UWFFn5fuMIIF2DCCA8CgAwIBAgIQTKr5yttjb+Af907YWwOGnTANBgkqhkiG9w0BAQwFADCBhTEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlm
aWNhdGlvbiBBdXRob3JpdHkwHhcNMTAwMTE5MDAwMDAwWhcNMzgwMTE4MjM1OTU5WjCBhTELMAkG
A1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEa
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
yUGg2hJZjrqck39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMB
AAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNVHQ4EFgQUgq9s
jPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwEQYD
VR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29t
L0NPTU9ET1JTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7Bggr
BgEFBQcwAoYvaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQw
JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
eFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+jsQgwRGiHjZrAYayZrrm78hOx7
aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDcZoFD7f3iT7PdkHJY9B51csvU50rxpEg1
OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wB
eKOdGCWn1/Jp2oY6dyNmNppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlc
rurffade2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvU
CIYZojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1Kc
L/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1II+3y
L8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5
v7zmEVDNXFnHn9tFpMpOUvxhcsjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIx
ggRlMIIEYQIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMT
NENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEDY3
A2GiKK2QlGjtkqwuGpMwCQYFKw4DAhoFAKCCAo0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTYwMzE1MTcyNDQ2WjAjBgkqhkiG9w0BCQQxFgQUv9UnVPOLo9KC/yMu
TdB8HgNGoZQwgasGCSqGSIb3DQEJDzGBnTCBmjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoG
CCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwBwYFKw4DAgcwDQYIKoZIhvcN
AwICAUAwDQYIKoZIhvcNAwICASgwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjAL
BglghkgBZQMEAgEwgb0GCSsGAQQBgjcQBDGBrzCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENB
IExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBT
ZWN1cmUgRW1haWwgQ0ECEDY3A2GiKK2QlGjtkqwuGpMwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGll
bnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQNjcDYaIorZCUaO2SrC4akzAN
BgkqhkiG9w0BAQEFAASCAQAkUKdIkNC0BX/BBdeALWKMQu6CVyj/MPHHyNfkB3NjO+MvejMTsAcj
PELJc7sEpRHST2IPdc4n1Zwxl3guu3waWvIJep70yZjsgtvXcrV4NT8GT7uwRK33Ghia23qpzOhG
4pvnKZbyNHUw2kYoAmkaLTpPVjh7JjccQFci+MPGvENqyrRPTJGNElw4YSiX3ijMnPSCJ3syQ4jt
w5CM6cS63Py7CtaNZeWcJyKoHxrwlQ+vEzjK5qFv0+IZbxmVi2U65MONgFVCVjdZCjujO5tTlw+n
etvCJzO/JPUlrdktp90U0Y6BDlu0/wHnWj/q3SROCql27arHJbWrpRJnum6TAAAAAAAA

------=_NextPart_000_00CD_01D17EAD.47633120--
