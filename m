From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 12:26:49 -0400
Message-ID: <48B82349.1020109@gmail.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <87abevpzv7.fsf@basil.nowhere.org> <48B81F60.3080409@gmail.com> <20080829162216.GW26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig35DF74AA4C68EBC63B46EFB2"
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757810AbYH2Q31@vger.kernel.org>
In-Reply-To: <20080829162216.GW26610@one.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35DF74AA4C68EBC63B46EFB2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andi Kleen wrote:
>> Im running it on a x86_64 box as we speak.  How can I tell if there is=
 a
>> certain mode that is permitting this?
>>    =20
>
> If the boot up says you're running with PMtimer then it uses the fallba=
ck
> (usually happens on pre Fam10h AMD boxes). A typical Intel box
> would use the faster ring 3 only TSC path and then explode with your
> change I bet.=20
>
> Or step with gdb through gettimeofday() and see if it does a syscall.
>
> -Andi
>  =20

It seems to be running fine with no indication it has fallen back.=20
Perhaps I need a certain workload to bring out the issue?

Here are some details of my system:

-------------------

ghaskins@test:~> uname -a
Linux test 2.6.26.3-rt3-rt #2 SMP PREEMPT RT Fri Aug 29 10:47:17 EDT
2008 x86_64 x86_64 x86_64 GNU/Linux
ghaskins@test:~> cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 15
model name    : Intel(R) Xeon(R) CPU            5130  @ 2.00GHz
stepping    : 6
cpu MHz        : 1995.006
cache size    : 4096 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 10
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
lm constant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx
tm2 ssse3 cx16 xtpr dca lahf_lm
bogomips    : 3992.49
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 15
model name    : Intel(R) Xeon(R) CPU            5130  @ 2.00GHz
stepping    : 6
cpu MHz        : 1995.006
cache size    : 4096 KB
physical id    : 3
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 6
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 10
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
lm constant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx
tm2 ssse3 cx16 xtpr dca lahf_lm
bogomips    : 3990.05
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 15
model name    : Intel(R) Xeon(R) CPU            5130  @ 2.00GHz
stepping    : 6
cpu MHz        : 1995.006
cache size    : 4096 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 10
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
lm constant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx
tm2 ssse3 cx16 xtpr dca lahf_lm
bogomips    : 3990.08
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 15
model name    : Intel(R) Xeon(R) CPU            5130  @ 2.00GHz
stepping    : 6
cpu MHz        : 1995.006
cache size    : 4096 KB
physical id    : 3
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 7
initial apicid    : 7
fpu        : yes
fpu_exception    : yes
cpuid level    : 10
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
lm constant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx
tm2 ssse3 cx16 xtpr dca lahf_lm
bogomips    : 3990.04
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

ghaskins@test:~> dmesg | grep -i "pmtimer"
ghaskins@test:~>




--------------enig35DF74AA4C68EBC63B46EFB2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki4I0kACgkQP5K2CMvXmqGv9QCcCajSM3XpLEwRKvFc6Y1G5SyP
XpcAnioYZjXY44wu1zRcF2jMdXI+ouLe
=ZbkH
-----END PGP SIGNATURE-----

--------------enig35DF74AA4C68EBC63B46EFB2--
