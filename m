From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cyclictest: remove compatibilty hack for old libnuma,
 repairs "-a" for isolcpus
Date: Wed, 20 May 2015 21:54:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505202153100.4225@nanos>
References: <20150427125846.1de46037@sluggy> <1432126711-18618-1-git-send-email-henning.schild@siemens.com> <alpine.LFD.2.10.1505201629400.7867@riemann>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1746178683-1432151656=:4225"
Cc: Henning Schild <henning.schild@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@gmail.com>,
	"Gary S. Robertson" <gary.robertson@linaro.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34792 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbbETTyH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 May 2015 15:54:07 -0400
In-Reply-To: <alpine.LFD.2.10.1505201629400.7867@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1746178683-1432151656=:4225
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 20 May 2015, John Kacur wrote:
> This is a terrible hack, but I'm afraid to remove it yet.
> Even systems as recent as Fedora 19 have a libnuma less than that.
> pm -qf /usr/lib64/libnuma.so
> numactl-devel-2.0.8-4.fc19.x86_64
> [jkacur@riemann rt-tests]$ cat /etc/fedora-release 
> Fedora release 19 (Schrödinger’s Cat)
> 
> This is causing problems for people who want to pin threads to 
> CPUs isolated with isolcpus=, so we do need to do something about.
> 
> I could perhaps accept an improved hack that tests whether the hack itself 
> is needed, until we have a better solution.

I'm not a great fan of it, but I think that rt-tests really needs
proper automake with proper tests for various bits and pieces.

Thanks,

	tglx
--8323329-1746178683-1432151656=:4225--
