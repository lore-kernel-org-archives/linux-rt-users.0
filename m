From: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Subject: Re: VirtualBox 4.2.4 freezes PC using RT_PREEMPT kernel
Date: Wed, 19 Dec 2012 14:44:50 +0000
Message-ID: <F9467A784CC48947B1D879F07370839E0EBCEA22@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F9467A784CC48947B1D879F07370839E0EBCEA22fe20099secnetas_"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:32147 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab2LSOp6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 09:45:58 -0500
Received: from smtp2-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 21FB92807D0
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Dec 2012 15:45:57 +0100 (CET)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--_002_F9467A784CC48947B1D879F07370839E0EBCEA22fe20099secnetas_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

> >
> > I have detected the following issue:
> > I use an x86 PC using kernel 3.2.34-rt51 and I want to run VirtualBox 4=
.2.4 using
> this PC as host.
>=20
> > However, the PC freezes completely when loading the vbox driver "vboxdr=
v".
> > Using the very same kernel without the RT_PREEMPT patch shows no issues=
.
> >
> > Using an older version of VirtualBox (V4.1.22) works fine as well.
> >
> > I know that this might be slightly off-topic. However there might be so=
me
> RT_PREEMPT users that have detected the same issue and know a solution fo=
r this.
> >
> > I have attached my kernel .config file.
> >
> > Thanks for any feedback on this.
>=20
> Try enabling lock debugging. Likely there is an incompatibility in the
> vbox driver or even a bug, and that may reveal more details.
>=20
> Otherwise: KVM is the better choice on Linux hosts, and it works fine
> over -rt.
I am about to try this out in parallel. It looks promising...


In addition, I did a long debug session (using a parallel port LED adapter =
any many PC resets...) to identify the issue.
Lock debugging did not work as really everything was frozen or the PC.
However, I finally identified the critical lines of code.
The relevant source file is the attached file "spinlock-r0drv-linux.c" of t=
he VirtualBox OSE V4.2.4.
The freeze happens in line 158 (spin_unlock_irqrestore()).

----------- BEGIN CODE FRAGMENT --------------------
RTDECL(void) RTSpinlockRelease(RTSPINLOCK Spinlock)
{
    PRTSPINLOCKINTERNAL pThis =3D (PRTSPINLOCKINTERNAL)Spinlock;
    RT_ASSERT_PREEMPT_CPUID_SPIN_RELEASE_VARS();
    AssertMsg(pThis && pThis->u32Magic =3D=3D RTSPINLOCK_MAGIC,
              ("pThis=3D%p u32Magic=3D%08x\n", pThis, pThis ? (int)pThis->u=
32Magic : 0));
    RT_ASSERT_PREEMPT_CPUID_SPIN_RELEASE(pThis);

    if (pThis->fFlags & RTSPINLOCK_FLAGS_INTERRUPT_SAFE)
    {
        unsigned long fIntSaved =3D pThis->fIntSaved;
        pThis->fIntSaved =3D 0;
        spin_unlock_irqrestore(&pThis->Spinlock, fIntSaved);   // <--- Here=
 is the freeze!
    }
    else
        spin_unlock(&pThis->Spinlock);

    RT_ASSERT_PREEMPT_CPUID();
}
RT_EXPORT_SYMBOL(RTSpinlockRelease);
----------- END CODE FRAGMENT --------------------

It has something to do with the spin locks used in VirtualBox.
Likely it does not consider the RT_PREEMPT use case here...
Is there a way to make the spin lock calls compatible to the RT_PREEMPT pat=
ch?

Any ideas for solving this issue are highly welcome!

Thanks a lot.
Best regards.

Mathias


--_002_F9467A784CC48947B1D879F07370839E0EBCEA22fe20099secnetas_
Content-Type: text/plain; name="spinlock-r0drv-linux.c"
Content-Description: spinlock-r0drv-linux.c
Content-Disposition: attachment; filename="spinlock-r0drv-linux.c"; size=5729;
	creation-date="Wed, 19 Dec 2012 14:24:34 GMT";
	modification-date="Fri, 26 Oct 2012 17:25:00 GMT"
Content-Transfer-Encoding: base64

LyogJElkOiBzcGlubG9jay1yMGRydi1saW51eC5jICQgKi8KLyoqIEBmaWxlCiAqIElQUlQgLSBT
cGlubG9ja3MsIFJpbmctMCBEcml2ZXIsIExpbnV4LgogKi8KCi8qCiAqIENvcHlyaWdodCAoQykg
MjAwNi0yMDEwIE9yYWNsZSBDb3Jwb3JhdGlvbgogKgogKiBUaGlzIGZpbGUgaXMgcGFydCBvZiBW
aXJ0dWFsQm94IE9wZW4gU291cmNlIEVkaXRpb24gKE9TRSksIGFzCiAqIGF2YWlsYWJsZSBmcm9t
IGh0dHA6Ly93d3cudmlydHVhbGJveC5vcmcuIFRoaXMgZmlsZSBpcyBmcmVlIHNvZnR3YXJlOwog
KiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VCiAqIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgKEdQTCkgYXMgcHVibGlzaGVk
IGJ5IHRoZSBGcmVlIFNvZnR3YXJlCiAqIEZvdW5kYXRpb24sIGluIHZlcnNpb24gMiBhcyBpdCBj
b21lcyBpbiB0aGUgIkNPUFlJTkciIGZpbGUgb2YgdGhlCiAqIFZpcnR1YWxCb3ggT1NFIGRpc3Ry
aWJ1dGlvbi4gVmlydHVhbEJveCBPU0UgaXMgZGlzdHJpYnV0ZWQgaW4gdGhlCiAqIGhvcGUgdGhh
dCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZIG9mIGFueSBraW5k
LgogKgogKiBUaGUgY29udGVudHMgb2YgdGhpcyBmaWxlIG1heSBhbHRlcm5hdGl2ZWx5IGJlIHVz
ZWQgdW5kZXIgdGhlIHRlcm1zCiAqIG9mIHRoZSBDb21tb24gRGV2ZWxvcG1lbnQgYW5kIERpc3Ry
aWJ1dGlvbiBMaWNlbnNlIFZlcnNpb24gMS4wCiAqIChDRERMKSBvbmx5LCBhcyBpdCBjb21lcyBp
biB0aGUgIkNPUFlJTkcuQ0RETCIgZmlsZSBvZiB0aGUKICogVmlydHVhbEJveCBPU0UgZGlzdHJp
YnV0aW9uLCBpbiB3aGljaCBjYXNlIHRoZSBwcm92aXNpb25zIG9mIHRoZQogKiBDRERMIGFyZSBh
cHBsaWNhYmxlIGluc3RlYWQgb2YgdGhvc2Ugb2YgdGhlIEdQTC4KICoKICogWW91IG1heSBlbGVj
dCB0byBsaWNlbnNlIG1vZGlmaWVkIHZlcnNpb25zIG9mIHRoaXMgZmlsZSB1bmRlciB0aGUKICog
dGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgZWl0aGVyIHRoZSBHUEwgb3IgdGhlIENEREwgb3IgYm90
aC4KICovCgoKLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKKiAgIEhlYWRlciBGaWxlcyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoK
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKi8KI2luY2x1ZGUgInRoZS1saW51eC1rZXJuZWwuaCIKI2lu
Y2x1ZGUgImludGVybmFsL2lwcnQuaCIKI2luY2x1ZGUgPGlwcnQvc3BpbmxvY2suaD4KCiNpbmNs
dWRlIDxpcHJ0L2FzbS5oPgojaWYgZGVmaW5lZChSVF9BUkNIX0FNRDY0KSB8fCBkZWZpbmVkKFJU
X0FSQ0hfWDg2KQojIGluY2x1ZGUgPGlwcnQvYXNtLWFtZDY0LXg4Ni5oPgojZW5kaWYKI2luY2x1
ZGUgPGlwcnQvYXNzZXJ0Lmg+CiNpbmNsdWRlIDxpcHJ0L2Vyci5oPgojaW5jbHVkZSA8aXBydC9t
ZW0uaD4KI2luY2x1ZGUgPGlwcnQvbXAuaD4KI2luY2x1ZGUgPGlwcnQvdGhyZWFkLmg+CiNpbmNs
dWRlICJpbnRlcm5hbC9tYWdpY3MuaCIKCgovKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgoqICAgU3Ry
dWN0dXJlcyBhbmQgVHlwZWRlZnMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKgoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwovKioKICogV3JhcHBlciBm
b3IgdGhlIHNwaW5sb2NrX3Qgc3RydWN0dXJlLgogKi8KdHlwZWRlZiBzdHJ1Y3QgUlRTUElOTE9D
S0lOVEVSTkFMCnsKICAgIC8qKiBTcGlubG9jayBtYWdpYyB2YWx1ZSAoUlRTUElOTE9DS19NQUdJ
QykuICovCiAgICB1aW50MzJfdCB2b2xhdGlsZSAgICAgICB1MzJNYWdpYzsKICAgIC8qKiBUaGUg
c3BpbmxvY2sgY3JlYXRpb24gZmxhZ3MuICAqLwogICAgdWludDMyX3QgICAgICAgICAgICAgICAg
ZkZsYWdzOwogICAgLyoqIFRoZSBzYXZlZCBpbnRlcnJ1cHQgZmxhZy4gKi8KICAgIHVuc2lnbmVk
IGxvbmcgdm9sYXRpbGUgIGZJbnRTYXZlZDsKICAgIC8qKiBUaGUgbGludXggc3BpbmxvY2sgc3Ry
dWN0dXJlLiAqLwogICAgc3BpbmxvY2tfdCAgICAgICAgICAgICAgU3BpbmxvY2s7CiNpZmRlZiBS
VF9NT1JFX1NUUklDVAogICAgLyoqIFRoZSBpZEFzc2VydENwdSB2YXJpYWJsZSBiZWZvcmUgYWNx
dXJpbmcgdGhlIGxvY2sgZm9yIGFzc2VydGluZyBhZnRlcgogICAgICogIHJlbGVhc2luZyB0aGUg
c3BpbmxvY2suICovCiAgICBSVENQVUlEIHZvbGF0aWxlICAgICAgICBpZEFzc2VydENwdTsKICAg
IC8qKiBUaGUgQ1BVIHRoYXQgb3ducyB0aGUgbG9jay4gKi8KICAgIFJUQ1BVSUQgdm9sYXRpbGUg
ICAgICAgIGlkQ3B1T3duZXI7CiNlbmRpZgp9IFJUU1BJTkxPQ0tJTlRFUk5BTCwgKlBSVFNQSU5M
T0NLSU5URVJOQUw7CgoKClJUREVDTChpbnQpICBSVFNwaW5sb2NrQ3JlYXRlKFBSVFNQSU5MT0NL
IHBTcGlubG9jaywgdWludDMyX3QgZkZsYWdzLCBjb25zdCBjaGFyICpwc3pOYW1lKQp7CiAgICBQ
UlRTUElOTE9DS0lOVEVSTkFMIHBUaGlzOwogICAgQXNzZXJ0UmV0dXJuKGZGbGFncyA9PSBSVFNQ
SU5MT0NLX0ZMQUdTX0lOVEVSUlVQVF9TQUZFIHx8IGZGbGFncyA9PSBSVFNQSU5MT0NLX0ZMQUdT
X0lOVEVSUlVQVF9VTlNBRkUsIFZFUlJfSU5WQUxJRF9QQVJBTUVURVIpOwoKICAgIC8qCiAgICAg
KiBBbGxvY2F0ZS4KICAgICAqLwogICAgQXNzZXJ0KHNpemVvZihSVFNQSU5MT0NLSU5URVJOQUwp
ID4gc2l6ZW9mKHZvaWQgKikpOwogICAgcFRoaXMgPSAoUFJUU1BJTkxPQ0tJTlRFUk5BTClSVE1l
bUFsbG9jKHNpemVvZigqcFRoaXMpKTsKICAgIGlmICghcFRoaXMpCiAgICAgICAgcmV0dXJuIFZF
UlJfTk9fTUVNT1JZOwogICAgLyoKICAgICAqIEluaXRpYWxpemUgYW5kIHJldHVybi4KICAgICAq
LwogICAgcFRoaXMtPnUzMk1hZ2ljICAgICA9IFJUU1BJTkxPQ0tfTUFHSUM7CiAgICBwVGhpcy0+
ZkZsYWdzICAgICAgID0gZkZsYWdzOwogICAgcFRoaXMtPmZJbnRTYXZlZCAgICA9IDA7CiNpZmRl
ZiBSVF9NT1JFX1NUUklDVAogICAgcFRoaXMtPmlkQ3B1T3duZXIgICA9IE5JTF9SVENQVUlEOwog
ICAgcFRoaXMtPmlkQXNzZXJ0Q3B1ICA9IE5JTF9SVENQVUlEOwojZW5kaWYKICAgIHNwaW5fbG9j
a19pbml0KCZwVGhpcy0+U3BpbmxvY2spOwoKICAgICpwU3BpbmxvY2sgPSBwVGhpczsKICAgIHJl
dHVybiBWSU5GX1NVQ0NFU1M7Cn0KUlRfRVhQT1JUX1NZTUJPTChSVFNwaW5sb2NrQ3JlYXRlKTsK
CgpSVERFQ0woaW50KSAgUlRTcGlubG9ja0Rlc3Ryb3koUlRTUElOTE9DSyBTcGlubG9jaykKewog
ICAgLyoKICAgICAqIFZhbGlkYXRlIGlucHV0LgogICAgICovCiAgICBQUlRTUElOTE9DS0lOVEVS
TkFMIHBUaGlzID0gKFBSVFNQSU5MT0NLSU5URVJOQUwpU3BpbmxvY2s7CiAgICBpZiAoIXBUaGlz
KQogICAgICAgIHJldHVybiBWRVJSX0lOVkFMSURfUEFSQU1FVEVSOwogICAgaWYgKHBUaGlzLT51
MzJNYWdpYyAhPSBSVFNQSU5MT0NLX01BR0lDKQogICAgewogICAgICAgIEFzc2VydE1zZ0ZhaWxl
ZCgoIkludmFsaWQgc3BpbmxvY2sgJXAgbWFnaWM9JSN4XG4iLCBwVGhpcywgcFRoaXMtPnUzMk1h
Z2ljKSk7CiAgICAgICAgcmV0dXJuIFZFUlJfSU5WQUxJRF9QQVJBTUVURVI7CiAgICB9CgogICAg
QVNNQXRvbWljSW5jVTMyKCZwVGhpcy0+dTMyTWFnaWMpOwogICAgUlRNZW1GcmVlKHBUaGlzKTsK
ICAgIHJldHVybiBWSU5GX1NVQ0NFU1M7Cn0KUlRfRVhQT1JUX1NZTUJPTChSVFNwaW5sb2NrRGVz
dHJveSk7CgoKUlRERUNMKHZvaWQpIFJUU3BpbmxvY2tBY3F1aXJlKFJUU1BJTkxPQ0sgU3Bpbmxv
Y2spCnsKICAgIFBSVFNQSU5MT0NLSU5URVJOQUwgcFRoaXMgPSAoUFJUU1BJTkxPQ0tJTlRFUk5B
TClTcGlubG9jazsKICAgIFJUX0FTU0VSVF9QUkVFTVBUX0NQVUlEX1ZBUigpOwogICAgQXNzZXJ0
TXNnKHBUaGlzICYmIHBUaGlzLT51MzJNYWdpYyA9PSBSVFNQSU5MT0NLX01BR0lDLAogICAgICAg
ICAgICAgICgicFRoaXM9JXAgdTMyTWFnaWM9JTA4eFxuIiwgcFRoaXMsIHBUaGlzID8gKGludClw
VGhpcy0+dTMyTWFnaWMgOiAwKSk7CgogICAgaWYgKHBUaGlzLT5mRmxhZ3MgJiBSVFNQSU5MT0NL
X0ZMQUdTX0lOVEVSUlVQVF9TQUZFKQogICAgewogICAgICAgIHVuc2lnbmVkIGxvbmcgZkludFNh
dmVkOwogICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZwVGhpcy0+U3BpbmxvY2ssIGZJbnRTYXZl
ZCk7CiAgICAgICAgcFRoaXMtPmZJbnRTYXZlZCA9IGZJbnRTYXZlZDsKICAgIH0KICAgIGVsc2UK
ICAgICAgICBzcGluX2xvY2soJnBUaGlzLT5TcGlubG9jayk7CgogICAgUlRfQVNTRVJUX1BSRUVN
UFRfQ1BVSURfU1BJTl9BQ1FVSVJFRChwVGhpcyk7Cn0KUlRfRVhQT1JUX1NZTUJPTChSVFNwaW5s
b2NrQWNxdWlyZSk7CgoKUlRERUNMKHZvaWQpIFJUU3BpbmxvY2tSZWxlYXNlKFJUU1BJTkxPQ0sg
U3BpbmxvY2spCnsKICAgIFBSVFNQSU5MT0NLSU5URVJOQUwgcFRoaXMgPSAoUFJUU1BJTkxPQ0tJ
TlRFUk5BTClTcGlubG9jazsKICAgIFJUX0FTU0VSVF9QUkVFTVBUX0NQVUlEX1NQSU5fUkVMRUFT
RV9WQVJTKCk7CiAgICBBc3NlcnRNc2cocFRoaXMgJiYgcFRoaXMtPnUzMk1hZ2ljID09IFJUU1BJ
TkxPQ0tfTUFHSUMsCiAgICAgICAgICAgICAgKCJwVGhpcz0lcCB1MzJNYWdpYz0lMDh4XG4iLCBw
VGhpcywgcFRoaXMgPyAoaW50KXBUaGlzLT51MzJNYWdpYyA6IDApKTsKICAgIFJUX0FTU0VSVF9Q
UkVFTVBUX0NQVUlEX1NQSU5fUkVMRUFTRShwVGhpcyk7CgogICAgaWYgKHBUaGlzLT5mRmxhZ3Mg
JiBSVFNQSU5MT0NLX0ZMQUdTX0lOVEVSUlVQVF9TQUZFKQogICAgewogICAgICAgIHVuc2lnbmVk
IGxvbmcgZkludFNhdmVkID0gcFRoaXMtPmZJbnRTYXZlZDsKICAgICAgICBwVGhpcy0+ZkludFNh
dmVkID0gMDsKICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwVGhpcy0+U3BpbmxvY2ss
IGZJbnRTYXZlZCk7CiAgICB9CiAgICBlbHNlCiAgICAgICAgc3Bpbl91bmxvY2soJnBUaGlzLT5T
cGlubG9jayk7CgogICAgUlRfQVNTRVJUX1BSRUVNUFRfQ1BVSUQoKTsKfQpSVF9FWFBPUlRfU1lN
Qk9MKFJUU3BpbmxvY2tSZWxlYXNlKTsKCgpSVERFQ0wodm9pZCkgUlRTcGlubG9ja1JlbGVhc2VO
b0ludHMoUlRTUElOTE9DSyBTcGlubG9jaykKewojaWYgMQogICAgaWYgKFJUX1VOTElLRUxZKCEo
U3BpbmxvY2stPmZGbGFncyAmIFJUU1BJTkxPQ0tfRkxBR1NfSU5URVJSVVBUX1NBRkUpKSkKICAg
ICAgICBSVEFzc2VydE1zZzIoIlJUU3BpbmxvY2tSZWxlYXNlTm9JbnRzOiAlcCAobWFnaWM9JSN4
KVxuIiwgU3BpbmxvY2ssIFNwaW5sb2NrLT51MzJNYWdpYyk7CiNlbHNlCiAgICBBc3NlcnRSZWxl
YXNlKFNwaW5sb2NrLT5mRmxhZ3MgJiBSVFNQSU5MT0NLX0ZMQUdTX0lOVEVSUlVQVF9TQUZFKTsK
I2VuZGlmCiAgICBSVFNwaW5sb2NrUmVsZWFzZShTcGlubG9jayk7Cn0KUlRfRVhQT1JUX1NZTUJP
TChSVFNwaW5sb2NrUmVsZWFzZU5vSW50cyk7Cgo=

--_002_F9467A784CC48947B1D879F07370839E0EBCEA22fe20099secnetas_--
