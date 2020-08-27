Return-Path: <SRS0=N+eC=CF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF24C433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17A02080C
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 15:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgH0PS3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:18:29 -0400
Received: from mail.monom.org ([188.138.9.77]:50344 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgH0Lfv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Aug 2020 07:35:51 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id CA69650035A;
        Thu, 27 Aug 2020 13:27:05 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 851D6500103;
        Thu, 27 Aug 2020 13:27:05 +0200 (CEST)
Date:   Thu, 27 Aug 2020 13:27:05 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200827112705.uleixtdmx3pacr5u@beryllium.lan>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
 <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
 <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
 <20200827092743.kjl6hkaephx3a64a@linutronix.de>
 <20200827101622.xx4jzecouxrlwbii@beryllium.lan>
 <20200827102840.msv556nrah4h4vmq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200827102840.msv556nrah4h4vmq@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 27, 2020 at 12:28:40PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-08-27 12:16:22 [+0200], Daniel Wagner wrote:
> > The -rt kernel is roughly 6MB larger. Just need to check the memory
> > ranges u-boot is using.
> 
> so that 6MiB sounded bad but then it is ~36MiB in total so….
> Is this full debug and so on?

I didn't really try to minimize the kernel. I haven't checked yet
if 5.6-rt is also showing this size increase. At least, our SUSE spin
off from v5.4-rt doesn't have this size increase with the same config.

Would be interesting to see the size numbers for v5.6-rt? Hmm, I'll
just start the compiler. It's all scripted anyway :)

Anyway, the config is:

  make defconfig

and

#
# Networking
#
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y

# NFS
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_ROOT_NFS=y

#
# Debugging
#
CONFIG_DEBUG_INFO=y
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7

# Embedded config to kernel. /proc/config.gz
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y

CONFIG_KEXEC=y

# Default settings
#
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCKDEP is not set

CONFIG_DEBUG_ATOMIC_SLEEP=y

# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_IDLE is not set

# CONFIG_NO_HZ is not set
CONFIG_HZ_PERIODIC=y

CONFIG_HZ_250=y
CONFIG_HZ=250

# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set

# cyclicdeadline dependency
CONFIG_SCHED_DEBUG=y

CONFIG_RCU_EXPERT=y
CONFIG_RCU_NOCB_CPU=y

# tracing
CONFIG_EMBEDDED=y
CONFIG_EXPERT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_SCHED_TRACER=y

CONFIG_PREEMPT_RT=y
