From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 09/11] slab, lockdep: Fix silly bug
Date: Mon, 5 Dec 2011 15:04:43 +0200 (EET)
Message-ID: <alpine.LFD.2.02.1112051503400.8257@tux.localdomain>
References: <20111204185444.411298317@goodmis.org> <20111204190021.812654254@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable@kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Hans Schillstrom <hans@schillstrom.com>,
	Christoph Lameter <cl@gentwo.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Matt Mackall <mpm@selenic.com>,
	Sitsofe Wheeler <sitsofe@yahoo.com>, linux-mm@kvack.org,
	David Rientjes <rientjes@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45844 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756300Ab1LENE5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Dec 2011 08:04:57 -0500
In-Reply-To: <20111204190021.812654254@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 4 Dec 2011, Steven Rostedt wrote:
> --00GvhwF7k39YY
> Content-Type: text/plain; charset="UTF-8"
> Content-Transfer-Encoding: quoted-printable
>
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
>
> Commit 30765b92 ("slab, lockdep: Annotate the locks before using
> them") moves the init_lock_keys() call from after g_cpucache_up =3D
> FULL, to before it. And overlooks the fact that init_node_lock_keys()
> tests for it and ignores everything !FULL.
>
> Introduce a LATE stage and change the lockdep test to be <LATE.
>
> Cc: stable@kernel.org
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Hans Schillstrom <hans@schillstrom.com>
> Cc: Christoph Lameter <cl@gentwo.org>
> Cc: Pekka Enberg <penberg@cs.helsinki.fi>
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: Sitsofe Wheeler <sitsofe@yahoo.com>
> Cc: linux-mm@kvack.org
> Cc: David Rientjes <rientjes@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: http://lkml.kernel.org/n/tip-gadqbdfxorhia1w5ewmoiodd@git.kernel.org
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Your emails seem to be damaged in interesting ways.

I assume the patch is going through the lockdep tree? If so, please make 
sure you include Christoph's ACK in the changelog.

 			Pekka
