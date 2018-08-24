From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 4.14.63-rt40
Date: Thu, 23 Aug 2018 20:32:23 -0400
Message-ID: <20180823203223.11dee5e8@vmware.local.home>
References: <20180822141458.0b6b6af7@gandalf.local.home>
        <CY1PR0501MB14666E51F4D066F2E0C5208AC5370@CY1PR0501MB1466.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: Tiejun Chen <tiejunc@vmware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CY1PR0501MB14666E51F4D066F2E0C5208AC5370@CY1PR0501MB1466.namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 23 Aug 2018 09:31:09 +0000
Tiejun Chen <tiejunc@vmware.com> wrote:

> Steven,
> 
> commit 7f11a591bbdb111792298144c3476506aa7f1ca8 (HEAD -> v4.14.63-rt40-rebase, tag: v4.14.63-rt40-rebase, origin/v4.14-rt-rebase)
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Wed May 16 09:33:00 2018 -0400
> 
>     Linux 4.14.63-rt40 REBASE
> 
> diff --git a/localversion-rt b/localversion-rt
> index 90290c642ed5..a3b2408c1da6 100644
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt29
> +-rt37
>     ^
> Isn't it supposed to be rt40?
> 

Ug, the last step of creating the rebase is to manually update the
localversion-rt file. Which I did. But I forgot to add "-a" to the 
"git commit --amend" part. Thanks for pointing this out!

Luckily, this is the rebase branch, where I can just rebase it ;-)

-- Steve
