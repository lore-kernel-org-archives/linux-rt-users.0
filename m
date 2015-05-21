From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: remove compatibilty hack for old libnuma,
 repairs "-a" for isolcpus
Date: Thu, 21 May 2015 13:23:08 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1505211322460.6537@riemann.fritz.box>
References: <20150427125846.1de46037@sluggy> <1432126711-18618-1-git-send-email-henning.schild@siemens.com> <alpine.LFD.2.10.1505201629400.7867@riemann> <alpine.DEB.2.11.1505202153100.4225@nanos>
 <CAONaPpGpzzgjxQh+214cfOBVrqeX_yX=Kh981YyveHhTgyLA4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463804494-1973922190-1432207391=:6537"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Henning Schild <henning.schild@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	"Gary S. Robertson" <gary.robertson@linaro.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35872 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbbEULXN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 May 2015 07:23:13 -0400
Received: by wgbgq6 with SMTP id gq6so82292825wgb.3
        for <linux-rt-users@vger.kernel.org>; Thu, 21 May 2015 04:23:12 -0700 (PDT)
In-Reply-To: <CAONaPpGpzzgjxQh+214cfOBVrqeX_yX=Kh981YyveHhTgyLA4A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1973922190-1432207391=:6537
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 21 May 2015, John Kacur wrote:

> Sigh, okay, I'll look into that then.
> 
> On 20 May 2015 at 21:54, Thomas Gleixner <tglx@linutronix.de> wrote:
>       On Wed, 20 May 2015, John Kacur wrote:
>       > This is a terrible hack, but I'm afraid to remove it yet.
>       > Even systems as recent as Fedora 19 have a libnuma less than that.
>       > pm -qf /usr/lib64/libnuma.so
>       > numactl-devel-2.0.8-4.fc19.x86_64
>       > [jkacur@riemann rt-tests]$ cat /etc/fedora-release
>       > Fedora release 19 (Schrödinger’s Cat)
>       >
>       > This is causing problems for people who want to pin threads to
>       > CPUs isolated with isolcpus=, so we do need to do something about.
>       >
>       > I could perhaps accept an improved hack that tests whether the hack itself
>       > is needed, until we have a better solution.
> 
>       I'm not a great fan of it, but I think that rt-tests really needs
>       proper automake with proper tests for various bits and pieces.
> 
>       Thanks,
> 
>               tglx

Sigh, okay, I'll look into that then.

John
---1463804494-1973922190-1432207391=:6537--
