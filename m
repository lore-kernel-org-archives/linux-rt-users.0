From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.7-rt3
Date: Thu, 29 Jun 2017 07:02:36 +0200
Message-ID: <1498712556.17925.5.camel@gmx.de>
References: <20170627135750.dezrobqd4twryeeb@linutronix.de>
         <79973421-cb21-aa5c-29f7-d05dd57283cc@manjaro.org>
         <1498704913.6128.21.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Bernhard Landauer <oberon@manjaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:62036 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbdF2FCs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jun 2017 01:02:48 -0400
In-Reply-To: <1498704913.6128.21.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2017-06-29 at 04:55 +0200, Mike Galbraith wrote:
> 
> cpus_allowed became cpus_mask.  Anything (crash.. hohum, yet again)
> that rummages around in the kernels gizzard will have to adapt.

(wrt crash: nope, it doesn't care for a change)
