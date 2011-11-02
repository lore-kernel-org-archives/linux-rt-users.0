From: HUNG BUI <buihung@gmail.com>
Subject: Re: Linux RT patch for Pandaboard Omap 4 kernel 3.0.0-1205 error when compiling
Date: Wed, 2 Nov 2011 23:15:20 +0100
Message-ID: <CAF7pde9uc0sKQR4R36VN+YGa6FJ=CyzcSVqJJAoOJFUeEetXuQ@mail.gmail.com>
References: <CAF7pde80C8C=vfN34uR4rS2HZ2-pY0BBJ0EsWm612BgHgtfETw@mail.gmail.com>
	<CAFQPvXewJqhaAa-qE+MHLbe-9LWH-s8GshTXJV9YW1d0JhjTaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec5215c55bace2404b0c7cec1
Cc: linux-rt-users@vger.kernel.org
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58198 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab1KBWPV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Nov 2011 18:15:21 -0400
Received: by qabj40 with SMTP id j40so616748qab.19
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Nov 2011 15:15:20 -0700 (PDT)
In-Reply-To: <CAFQPvXewJqhaAa-qE+MHLbe-9LWH-s8GshTXJV9YW1d0JhjTaQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--bcaec5215c55bace2404b0c7cec1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Thank you Jiri and Sankara.

With your help I have successful compiled rt patch for Ubuntu on Pandaboard=
.

I found that the ti omap kernel I downloaded with the command:
 sudo apt-get source linux-image-$(uname -r)

( tar file : linux-ti-omap4_3.0.0-1205.10.tar.gz )
is kernel version 3.0.4 despite it numbered: 3.0.0-1205.

And it is the main reason why so many errors occurred when I try to
patch patch-3.0-rt6 with this kernel.

So I downloaded an earlier package :3.0.0-1201.5 at
https://launchpad.net/ubuntu/+source/linux-ti-omap4/3.0.0-1201.5 and
patch with patch-3.0.1-rt11 .

Then I only have to patch 03 errors to finish compiling.
My process (compiling on Panaboard running Ubuntu 11.10) is a little
bit different from yours, since i compile to generate .deb files.
Basically it is :

(1) tar xfv  linux-ti-omap4_3.0.0-1205.10.tar.gz
(2) cd to the folder extracted.

(3) Edit file patch-3.0.1-rt11.patch to delete this part :

Index: linux-2.6/localversion-rt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/localversion-rt
@@ -0,0 +1 @@
+-rt11


because it will make the compiler confuses between the local version
omap4 and omap4-rt11 ( I am not sure this patch is correct or not,
but without it I will have this error :

"run-parts: executing debian/tests/check-aliases

Checking for dupe aliases in omap4...
Could not open /usr/src/ubuntu-oneiric/debian/linux-image-3.0.0-1201-omap4/=
lib/modules/3.0.0-1201-omap4/modules.alias
at debian/tests/check-aliases line 10."


(4) patch -p1 < ./patch-3.0.1-rt11.patch
At this step, I have 1 unsuccessful patch with file /init/main.c
I follow the .rej file and patch it manually. I think it is because of
the omap4 kernel has some changes in main.c makes the patch does not
match.

(5) Edit file ubuntu-oneiric/ubuntu/aufs/mtx.h : change: lock->owner
to: lock->lock.owner
according to this patch :
http://aufs.git.sourceforge.net/git/gitweb.cgi?p=3Daufs/aufs2-standalone.gi=
t;a=3Dpatch;h=3D624d0435b28be8bce48ea30cf00c52f4e5623621


(6) Add  #include <linux/cache.h> to file
ubuntu-oneiric/security/apparmor/sid.c because of this error :

usr/src/linux-ti-omap4-3.0.0/security/apparmor/sid.c: In function
=91aa_alloc_sid=92:
/usr/src/linux-ti-omap4-3.0.0/security/apparmor/sid.c:42:2: error:
=91sid_lock=92 undeclared (first use in this function)

(7) fakeroot debian/rules editconfigs

I left everything default except:
# Kernel Features -> Preemption Model -> Fully Preemptible Kernel (RT)
# Kernel hacking -> Kernel Debugging =3D n
# System type -> TI Omap Common Feature -> Use 32KHz timer =3Dn

(8) I apply your patch you provided for high resolution timer and also
applied this patch from

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49148.html

( i am not sure the above patch needed or not, I attached the patch here)

(9) fakeroot debian/rules clean
skipabi=3Dtrue skipmodule=3Dtrue dpkg-buildpackage -B -uc -us

(wait 2 hours)

(10)
sudo dpkg -i linux-headers-3.0.0-1201_3.0.0-1201.5_armel.deb
sudo dpkg -i linux-headers-3.0.0-1201-omap4_3.0.0-1201.5_armel.deb
sudo dpkg -i linux-image-3.0.0-1201-omap4_3.0.0-1201.5_armel.deb

sudo flash-kernel 3.0.1-1201-omap4

After reboot, i have the realtime 3.0.1 omap4 running. The cyclictest
shows an acceptable result, with no load the maximum latency is around
30usec, with load it is ~150usec.

One good thing is I don;t have any problem when booting the new kernel.

However, I have that problem when compile generic kernel and applied
on minimal fs linux, instead of ubuntu, the same as you described, it
only boots after 5-10 resets.

The ubuntu kernel boots normally, but sometimes it hangs after boot,
when i try to do run tasks, Firefox for example.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

I have a question about the minimal systems, it may be ridiculous but
i don;t know how to get and run cyclictest, since I don;t have apt-get
package, also no git. As I understand, I will have to compile it on
pandaboard, but I found it hard to do it on the minimal fs.

And second question, when you cross compile with make ARCH=3Darm
CROSS_COMPILE=3Darm-angstrom-linux-gnueabi- uImage and get the uImage,
your pandaboard is running Ubuntu or minimal fs ?

Thank you very much for your support, it really helps me after 2 weeks
of compilation again and again.

Hung Bui

--bcaec5215c55bace2404b0c7cec1
Content-Type: application/octet-stream; name="sankara.patch"
Content-Disposition: attachment; filename="sankara.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_guikyvff0

KioqKioqKioqKioqIFBBVENIIFNUQVJUICoqKioqKioqKioqKioqCmRpZmYgLXJ1cE4gYS9hcmNo
L2FybS9tYWNoLW9tYXAyL3RpbWVyLWdwLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLWdw
LmMKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi90aW1lci1ncC5jCTIwMTEtMDYtMDYgMTA6NDI6
NDUuOTY0OTI0NjAzIC0wNTAwCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvdGltZXItZ3AuYwky
MDExLTA2LTA2IDEwOjQ0OjAzLjcyNTQyMjA3NyAtMDUwMApAQCAtMjMwLDYgKzIzMCwxMiBAQCBz
dGF0aWMgdm9pZCBfX2luaXQgb21hcDJfZ3BfY2xvY2tzb3VyY2VfCiAJc3RhdGljIGNoYXIgZXJy
MltdIF9faW5pdGRhdGEgPSBLRVJOX0VSUgogCQkiJXM6IGNhbid0IHJlZ2lzdGVyIGNsb2Nrc291
cmNlIVxuIjsKCisJY2hhciBjbG9ja3NvdXJjZV9od21vZF9uYW1lWzhdOyAvKiA4ID0gc2l6ZW9m
KCJ0aW1lclhYMCIpICovCisKKwkvKiBYWFg6IFRoaXMgbWF5IG5vdCBiZSBhbHdheXMgdHJ1ZSwg
d2UgbWlnaHQgZ2V0IGRpZmZlcmVudCB0aW1lciAqLworCXNwcmludGYoY2xvY2tzb3VyY2VfaHdt
b2RfbmFtZSwgInRpbWVyJWQiLCBncHRpbWVyX2lkICsgMSk7CisJb21hcF9od21vZF9zZXR1cF9v
bmUoY2xvY2tzb3VyY2VfaHdtb2RfbmFtZSk7CisKIAlncHQgPSBvbWFwX2RtX3RpbWVyX3JlcXVl
c3QoKTsKIAlpZiAoIWdwdCkKIAkJcHJpbnRrKGVycjEsIGNsb2Nrc291cmNlX2dwdC5uYW1lKTsK
CgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi90aW1lci1ncC5jIGIvYXJjaC9hcm0v
bWFjaC1vbWFwMi90aW1lci1ncC5jCmluZGV4IDNiOWNmODUuLmU3ODNiZmUgMTAwNjQ0Ci0tLSBh
L2FyY2gvYXJtL21hY2gtb21hcDIvdGltZXItZ3AuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAy
L3RpbWVyLWdwLmMKQEAgLTE5OCwxNSArMTk4LDIwIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFw
Ml9ncF9jbG9ja3NvdXJjZV9pbml0KHZvaWQpCiAgKi8KIHN0YXRpYyBERUZJTkVfQ0xPQ0tfREFU
QShjZCk7CiBzdGF0aWMgc3RydWN0IG9tYXBfZG1fdGltZXIgKmdwdF9jbG9ja3NvdXJjZTsKLXN0
YXRpYyBjeWNsZV90IGNsb2Nrc291cmNlX3JlYWRfY3ljbGVzKHN0cnVjdCBjbG9ja3NvdXJjZSAq
Y3MpCitzdGF0aWMgY3ljbGVfdCBub3RyYWNlIGNsb2Nrc291cmNlX3JlYWRfY3ljbGVzKHN0cnVj
dCBjbG9ja3NvdXJjZSAqY3MpCiB7CiAJcmV0dXJuIChjeWNsZV90KW9tYXBfZG1fdGltZXJfcmVh
ZF9jb3VudGVyKGdwdF9jbG9ja3NvdXJjZSk7CiB9Cgorc3RhdGljIGN5Y2xlX3Qgbm90cmFjZSBj
bG9ja3NvdXJjZV9ncHRfcmVhZF9kdW1teShzdHJ1Y3QgY2xvY2tzb3VyY2UgKmNzKQoreworCXJl
dHVybiAwOworfQorCiBzdGF0aWMgc3RydWN0IGNsb2Nrc291cmNlIGNsb2Nrc291cmNlX2dwdCA9
IHsKIAkubmFtZQkJPSAiZ3AgdGltZXIiLAogCS5yYXRpbmcJCT0gMzAwLAotCS5yZWFkCQk9IGNs
b2Nrc291cmNlX3JlYWRfY3ljbGVzLAorCS5yZWFkCQk9IGNsb2Nrc291cmNlX2dwdF9yZWFkX2R1
bW15LAogCS5tYXNrCQk9IENMT0NLU09VUkNFX01BU0soMzIpLAogCS5mbGFncwkJPSBDTE9DS19T
T1VSQ0VfSVNfQ09OVElOVU9VUywKIH07CkBAIC0yMjAsNiArMjI1LDEyIEBAIHN0YXRpYyB2b2lk
IG5vdHJhY2UgZG10aW1lcl91cGRhdGVfc2NoZWRfY2xvY2sodm9pZCkKIAl1cGRhdGVfc2NoZWRf
Y2xvY2soJmNkLCBjeWMsICh1MzIpfjApOwogfQoKK3Vuc2lnbmVkIGxvbmcgbG9uZyBub3RyYWNl
IHNjaGVkX2Nsb2NrKHZvaWQpCit7CisJdTMyIGN5YyA9IGNsb2Nrc291cmNlX2dwdC5yZWFkKCZj
bG9ja3NvdXJjZV9ncHQpOworCXJldHVybiBjeWNfdG9fc2NoZWRfY2xvY2soJmNkLCBjeWMsICh1
MzIpfjApOworfQorCiAvKiBTZXR1cCBmcmVlLXJ1bm5pbmcgY291bnRlciBmb3IgY2xvY2tzb3Vy
Y2UgKi8KIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFwMl9ncF9jbG9ja3NvdXJjZV9pbml0KHZvaWQp
CiB7CkBAIC0yNDAsNiArMjUxLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXAyX2dwX2Nsb2Nr
c291cmNlX2luaXQodm9pZCkKCiAJb21hcF9kbV90aW1lcl9zZXRfbG9hZF9zdGFydChncHQsIDEs
IDApOwoKKwljbG9ja3NvdXJjZV9ncHQucmVhZCA9IGNsb2Nrc291cmNlX3JlYWRfY3ljbGVzOwog
CWluaXRfc2NoZWRfY2xvY2soJmNkLCBkbXRpbWVyX3VwZGF0ZV9zY2hlZF9jbG9jaywgMzIsIHRp
Y2tfcmF0ZSk7CgogCWlmIChjbG9ja3NvdXJjZV9yZWdpc3Rlcl9oeigmY2xvY2tzb3VyY2VfZ3B0
LCB0aWNrX3JhdGUpKQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2NvdW50ZXJfMzJr
LmMgYi9hcmNoL2FybS9wbGF0LW9tYXAvY291bnRlcl8zMmsuYwppbmRleCBmN2ZlZDYwLi45MjMx
NDk5IDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAvY291bnRlcl8zMmsuYworKysgYi9h
cmNoL2FybS9wbGF0LW9tYXAvY291bnRlcl8zMmsuYwpAQCAtMTI2LDEzICsxMjYsMTMgQEAgc3Rh
dGljIGlubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgbm90cmFjZSBfb21hcF8zMmtfc2NoZWRfY2xv
Y2sodm9pZCkKIAlyZXR1cm4gY3ljX3RvX2ZpeGVkX3NjaGVkX2Nsb2NrKCZjZCwgY3ljLCAodTMy
KX4wLCBTQ19NVUxULCBTQ19TSElGVCk7CiB9CgotI2lmbmRlZiBDT05GSUdfT01BUF9NUFVfVElN
RVIKLXVuc2lnbmVkIGxvbmcgbG9uZyBub3RyYWNlIHNjaGVkX2Nsb2NrKHZvaWQpCisjaWZkZWYg
Q09ORklHX09NQVBfTVBVX1RJTUVSCit1bnNpZ25lZCBsb25nIGxvbmcgbm90cmFjZSBvbWFwXzMy
a19zY2hlZF9jbG9jayh2b2lkKQogewogCXJldHVybiBfb21hcF8zMmtfc2NoZWRfY2xvY2soKTsK
IH0KLSNlbHNlCi11bnNpZ25lZCBsb25nIGxvbmcgbm90cmFjZSBvbWFwXzMya19zY2hlZF9jbG9j
ayh2b2lkKQorI2VsaWYgZGVmaW5lZChDT05GSUdfT01BUF8zMktfVElNRVIpCit1bnNpZ25lZCBs
b25nIGxvbmcgbm90cmFjZSBzY2hlZF9jbG9jayh2b2lkKQogewogCXJldHVybiBfb21hcF8zMmtf
c2NoZWRfY2xvY2soKTsKIH0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9kbXRpbWVy
LmMgYi9hcmNoL2FybS9wbGF0LW9tYXAvZG10aW1lci5jCmluZGV4IGVlOWY2ZWIuLjA2NDhkNjMg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9kbXRpbWVyLmMKKysrIGIvYXJjaC9hcm0v
cGxhdC1vbWFwL2RtdGltZXIuYwpAQCAtNzAwLDcgKzcwMCw3IEBAIHZvaWQgb21hcF9kbV90aW1l
cl93cml0ZV9zdGF0dXMoc3RydWN0IG9tYXBfZG1fdGltZXIgKnRpbWVyLCB1bnNpZ25lZCBpbnQg
dmFsdWUpCiB9CiBFWFBPUlRfU1lNQk9MX0dQTChvbWFwX2RtX3RpbWVyX3dyaXRlX3N0YXR1cyk7
CgotdW5zaWduZWQgaW50IG9tYXBfZG1fdGltZXJfcmVhZF9jb3VudGVyKHN0cnVjdCBvbWFwX2Rt
X3RpbWVyICp0aW1lcikKK3Vuc2lnbmVkIGludCBub3RyYWNlIG9tYXBfZG1fdGltZXJfcmVhZF9j
b3VudGVyKHN0cnVjdCBvbWFwX2RtX3RpbWVyICp0aW1lcikKIHsKIAl1bnNpZ25lZCBpbnQgbDsK
CgoqKioqKioqKioqKiogUEFUQ0ggRU5EICoqKioqKioqKioqKioqCgo=
--bcaec5215c55bace2404b0c7cec1--
