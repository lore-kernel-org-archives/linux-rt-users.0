From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH] cyclictest: remove compatibilty hack for old libnuma,
 repairs "-a" for isolcpus
Date: Thu, 21 May 2015 13:11:19 +0200
Message-ID: <20150521131119.4909a2dd@md1em3qc>
References: <20150427125846.1de46037@sluggy>
	<1432126711-18618-1-git-send-email-henning.schild@siemens.com>
	<alpine.LFD.2.10.1505201629400.7867@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Gary S. Robertson" <gary.robertson@linaro.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:57919 "EHLO thoth.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328AbbEULdW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 May 2015 07:33:22 -0400
In-Reply-To: <alpine.LFD.2.10.1505201629400.7867@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 20 May 2015 16:38:25 +0200
John Kacur <jkacur@redhat.com> wrote:

> This is a terrible hack, but I'm afraid to remove it yet.
> Even systems as recent as Fedora 19 have a libnuma less than that.
> pm -qf /usr/lib64/libnuma.so
> numactl-devel-2.0.8-4.fc19.x86_64
> [jkacur@riemann rt-tests]$ cat /etc/fedora-release=20
> Fedora release 19 (Schr=C3=B6dinger=E2=80=99s Cat)

According to https://fedoraproject.org/wiki/Releases that is an old
unsupported release, so i would not call it recent. No funny state
inbetween, that cat is dead. As far as i can see Fedora 20+ should have
2.0.9+, which is fine.
If you ask me, a compatibilty hack that brakes all modern systems is no=
t
acceptable.

I do not know how many bits and pieces could be tuned, but automake for
that one issue seems overkill.

Henning
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
