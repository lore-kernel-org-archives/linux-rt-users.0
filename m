From: "Back, Michael (ext)" <michael.back.ext@siemens.com>
Subject: AW: KVM and Prempt?
Date: Wed, 24 Oct 2007 09:31:22 +0200
Message-ID: <003F437218F04842B2A6976FA19368B1887423@ERLM863A.ww001.siemens.net>
References: <003F437218F04842B2A6976FA19368B1886B99@ERLM863A.ww001.siemens.net> <1193076845.5738.23.camel@sven.thebigcorporation.com> <471DB250.3030301@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"Sven-Thorsten Dietrich" <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thelpusa.erlm.siemens.de ([217.194.34.71]:46202 "EHLO
	thelpusa.erlm.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbXJXHc1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 03:32:27 -0400
Content-class: urn:content-classes:message
In-Reply-To: <471DB250.3030301@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> -----Urspr=FCngliche Nachricht-----
> Von: Kiszka, Jan=20
> Gesendet: Tuesday, October 23, 2007 10:35 AM
> An: Sven-Thorsten Dietrich
> Cc: Back, Michael (ext); linux-rt-users@vger.kernel.org
> Betreff: Re: KVM and Prempt?
>=20
> Sven-Thorsten Dietrich wrote:
> > On Mon, 2007-10-22 at 09:01 +0200, Back, Michael (ext) wrote:
> >> Hallo,
> >> I tried to run Windows XP with KVM on Linux 2.6.31.1 on a=20
> >=20
> > You mean .21.1 ?=20
>=20
> Classic typo I interestingly also did several times the last week. :)
>=20
> >=20
> >> AMD Opteron and on a Intel Xeon, on both it works fine!
> >=20
> >> After this test I patch the kernel with the current=20
> prempt-patch and on
> >> both it doesn't works!=20
> >=20
> > Did you try against 2.6.23-rt1.
>=20
> kvm in -rt1 is not usable. It's too old, lacking PREEMPT_NOTIFIER
> support, thus quickly triggering lockdep.

Thanks, the kvm-devel list told me the same and it works !!!

Michael

>=20
> >=20
> > If you must stay on .21, you might have some other issues=20
> with the AMD
> > and NUMA.
> >=20
> > At the very least, you will need to apply the attached=20
> patch from git
> > somehow, although this patch is against a new scheduler=20
> post 2.6.22, so
> > good luck :)
>=20
> <--snip-->
>=20
> Those patches are already mainline... :->
>=20
> What you rather need are latest kvm patches, or - if building the kvm
> distribution out of tree - a patch to enabled CONFIG_PREEMPT_NOTIFIER=
S
> unconditionally:
>=20
> --- linux-2.6.23.1-rt/kernel/Kconfig.preempt.orig
> +++ linux-2.6.23.1-rt/kernel/Kconfig.preempt
> @@ -136,6 +136,7 @@
>=20
>  config PREEMPT_NOTIFIERS
>  	bool
> +	default y
>=20
>  config PREEMPT_BKL
>  	bool
>=20
>=20
> Still, I'm seeing oopses here (more precisely, lock validator
> complaints), but I need to re-test, better using kvm from git=20
> instead of
> kvm-48.
>=20
> Beyond this, I'm struggling to understand 300-400 us vm-exit latencie=
s
> (over Intel VMX), which appear to be independent of the underlying
> system. See kvm-devel. Such latencies would limit the RT usability of
> kvm - unless you spent dedicated CPUs.
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>=20
