Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:44965 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfA2SGy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Jan 2019 13:06:54 -0500
Date: Tue, 29 Jan 2019 19:06:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: ETA for 4.19rt-stable patch set?
Message-ID: <20190129180649.eudltfqqe2sen5nx@linutronix.de>
References: <D5D6254030DBC644B6EE58B333BFBB1EA7C440AB@ORSMSX101.amr.corp.intel.com>
 <D5D6254030DBC644B6EE58B333BFBB1EA7C44112@ORSMSX101.amr.corp.intel.com>
 <D5D6254030DBC644B6EE58B333BFBB1EA86D6207@ORSMSX122.amr.corp.intel.com>
 <CAJjrzcXsY87RVbcv0Nb-mzB0gX4mqD35uCr0H5Uk+PNnOzX_JQ@mail.gmail.com>
 <D5D6254030DBC644B6EE58B333BFBB1EA86D66C1@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D5D6254030DBC644B6EE58B333BFBB1EA86D66C1@ORSMSX122.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: "Hindman, Gavin" <gavin.hindman@intel.com>
Cc: Arve Barsnes <arve.barsnes@gmail.com>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2019-01-26 01:30:03 [+0000], Hindman, Gavin wrote:
> 
> My understanding is that the dev tree is just that - some work in
> progress so could be subject to transient latency and stability
> regressions.  Certainly, the dev tree generally works, but it's not
> guaranteed to remain that way.  The stable patch sets just get the
> changes considered truly stable.

I was waiting with my answer since I didn't know what the missing pieces
of information might be. With your text above tl;dr answer is that I
currently don't plan to add new rewrites to the dev RT tree.

The long version is:
v4.19 is currently in the dev-tree. It will be handed over to the stable
team once v5.0-RT is released (since it is the v4.19+2 release). This is
the basic workflow.

Given how long v4.19-RT is out, it should "stable" / it should not have
any known bugs / regressions. If so, I am not aware of it. If there is
anything, please let me know. If you haven't started using v4.19-RT yet,
please do so. The sooner problems are reported, the sooner people are
aware of them and may work on them.

At this point in time, I don't plan to throw any new patches into the
dev tree which would lead to a rewrite / change of RT behaviour.

How stable is stable. Around August I backported a handful patches for
v4.9-RT because futex was broken in some corner cases. The last v4.19-RT
release had a ptrace related fix which is or will be picked up by the RT
stable team. The locking latency problem on x86 for v4.1+ was routed via
the stable team (not the RT-stable team). So there is that.

Hope that answers your question.

Sebastian
