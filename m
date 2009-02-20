From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: loadavg problem with 2.6.26.8-rt16 on Atmel AT91SAM9260
Date: Fri, 20 Feb 2009 13:12:22 -0500
Message-ID: <7d1d9c250902201012r4a01ca2w2d4a4ef7ba4f9883@mail.gmail.com>
References: <Pine.LNX.4.64.0902191110060.22561@lxtpfaff.pcs.ditec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502cb58271d9904635d98cc
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Pfaff <tpfaff@pcs.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:61088 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbZBTSMY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2009 13:12:24 -0500
Received: by yx-out-2324.google.com with SMTP id 8so398322yxm.1
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Feb 2009 10:12:23 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0902191110060.22561@lxtpfaff.pcs.ditec.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--00504502cb58271d9904635d98cc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Thu, Feb 19, 2009 at 7:11 AM, Thomas Pfaff <tpfaff@pcs.com> wrote:
> While testing the 2.6.26.8-rt16 kernel on an AT91SAM9260-EK Arm9 board i noticed
> a small regression to 2.6.24.7-rt27.
>
> The kernel compiles and boots fine but the average load when the cpu is idle
> tends to be 1, it starts at 0 when the system boots and goes to 1 or above after
> some time.
>
> All kernels have the at91 patches from http://maxim.org.za/sam9.html
>
> Following kernels are ok:
>
> 2.6.24.7-rt27
> 2.6.26.8 without rt
>
> With the rt patch i have tested several combinations of the PREEMPT options:
>
> Without CONFIG_PREEMPT_HARDIRQ i get an oops on boot (see next mail).
>
> All other CONFIG_PREEMPT_[NONE|VOLUNTARY|DESKTOP|RT] options are working but
> with the wrong average load.

Please test the following patch.  I think you should find it fixes the problem.

Paul.

--00504502cb58271d9904635d98cc
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-softirq-loadavg-one-less-active-task.patch"
Content-Disposition: attachment;
	filename="0001-softirq-loadavg-one-less-active-task.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frf6hd540

RnJvbSAxMDkwNmVmYWIzNWI2ZjU2MWRlZmNlN2E5MGEyOTY3YTU0N2RlNWYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIEdvcnRtYWtlciA8cGF1bC5nb3J0bWFrZXJAd2luZHJp
dmVyLmNvbT4KRGF0ZTogTW9uLCAyNiBKYW4gMjAwOSAyMToxNTozMiAtMDUwMApTdWJqZWN0OiBb
UEFUQ0hdIHNvZnRpcnEgbG9hZGF2Zzogb25lIGxlc3MgYWN0aXZlIHRhc2sgaW4gUFJFRU1QVF9T
T0ZUSVJRIGxvYWRhdmcgY2FsYwoKQnVpbGRpbmcgd2l0aCBhIHR5cGljYWwgUlQgLmNvbmZpZywg
YnV0IHdpdGgganVzdCBQUkVFTVBUX1JUIGRpc2FibGVkLApvbmUgZ2V0cyBhIGtlcm5lbCB0aGF0
IGNvbnN0YW50bHkgc2hvd3MgYSBsb2FkYXZnIG9mIG9uZS4KCldoZW4gUlQgaXMgZW5hYmxlZCwg
d2Ugc3VidHJhY3Qgb25lIGZyb20gdGhlIG5yX2FjdGl2ZSBzaW5jZSB0aGVyZSBpcwphIGxvYWRh
dmcgdGhyZWFkIHdoaWNoIGNhbGxzIGNhbGNfbG9hZCgpLiAgQnV0IGluIHRoZSBQUkVFTVBUX1NP
RlRJUlEKY2FzZSwgd2Ugc2hvdWxkIGFsc28gc3VidHJhY3Qgb25lLCBzaW5jZSB3ZSBhcmUgc3Rp
bGwgY2FsbGluZyBpdCBmcm9tCmEgdGhyZWFkLCBhcyBpdCBpcyBjYWxsZWQgYXMgZm9sbG93czoK
CmluaXRfdGltZXJzKCkKCVxfIG9wZW5fc29mdGlycSguLi4sIHJ1bl90aW1lcl9zb2Z0aXJxLCAu
Li4pCgpydW5fdGltZXJfc29mdGlycSgpCglcXyB1cGRhdGVfdGltZXMoKQoJCVxfIGlmbmRlZiBQ
UkVFTVBUX1JUIGNhbGNfbG9hZCgpCgkJCVxfIGNvdW50X2FjdGl2ZV90YXNrcygpCgkJCQlcXyBu
cl9hY3RpdmUoKSwgb3IgbnJfYWN0aXZlKCktMSBmb3IgUlQuCgpGb3IgcmVmZXJlbmNlLCB0aGUg
b3JpZ2luYWwgUlQgcGF0Y2ggdGhhdCBpbnRyb2R1Y2VzIHRoZSAtMSBpcwpwcmVlbXB0LXJlYWx0
aW1lLXRpbWVyLnBhdGNoLCB0aGVuIGJ6MjM1MDk5LWlkbGUtbG9hZC1maXgucGF0Y2gKdXBkYXRl
cyBpdCB0byBhZGQvbWVudGlvbiB0aGUgdGhyZWFkZWQgY2FsY3VsYXRpb24gZm9yIFJULgoKU2ln
bmVkLW9mZi1ieTogUGF1bCBHb3J0bWFrZXIgPHBhdWwuZ29ydG1ha2VyQHdpbmRyaXZlci5jb20+
Ci0tLQoga2VybmVsL3RpbWVyLmMgfCAgICA3ICsrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lci5j
IGIva2VybmVsL3RpbWVyLmMKaW5kZXggNGRmMmQ1MC4uZWFlODEzYSAxMDA2NDQKLS0tIGEva2Vy
bmVsL3RpbWVyLmMKKysrIGIva2VybmVsL3RpbWVyLmMKQEAgLTEwNjUsOSArMTA2NSwxMiBAQCBz
dGF0aWMgdW5zaWduZWQgbG9uZyBjb3VudF9hY3RpdmVfdGFza3Modm9pZCkKIHsKIAkvKgogCSAq
IE9uIFBSRUVNUFRfUlQsIHdlIGFyZSBydW5uaW5nIGluIHRoZSBsb2FkYXZnIHRocmVhZCwKLQkg
KiBzbyBjb25zaWRlciAxIGxlc3MgcnVubmluZyB0YXNrczoKKwkgKiBhbmQgc2ltaWxhcmx5IGlm
IHdlIGFyZSBvbmx5IHJ1bm5pbmcgUFJFRU1QVF9TT0ZUSVJRUyB3ZQorCSAqIGFyZSBydW5uaW5n
IGluIHRoZSBydW5fdGltZXJfc29mdGlycSB0aHJlYWQsIHNvIGNvbnNpZGVyCisJICogb25lIGxl
c3MgcnVubmluZyB0YXNrIGluIHRoZXNlIHR3byBjYXNlcy4gKFBSRUVNUFRfUlQKKwkgKiBzZWxl
Y3RzIFBSRUVNUFRfU09GVElSUSwgc28gd2UgZ2V0IGJvdGggdmlhIHRoZSBsYXR0ZXIpCiAJICov
Ci0jaWZkZWYgQ09ORklHX1BSRUVNUFRfUlQKKyNpZmRlZiBDT05GSUdfUFJFRU1QVF9TT0ZUSVJR
UwogCXJldHVybiAobnJfYWN0aXZlKCkgLSAxKSAqIEZJWEVEXzE7CiAjZWxzZQogCXJldHVybiBu
cl9hY3RpdmUoKSAqIEZJWEVEXzE7Ci0tIAoxLjYuMC40Cgo=
--00504502cb58271d9904635d98cc--
