Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBD3C77B71
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Apr 2023 15:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDNPjA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Apr 2023 11:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNPi7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Apr 2023 11:38:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9419793CC;
        Fri, 14 Apr 2023 08:38:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44A011FD81;
        Fri, 14 Apr 2023 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681486737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bY/3sIZBuDDsO2F5msp8P1kEIGv7QfIYkVdOIXA8f08=;
        b=ZCsh/gAx61h68o7GZJmhhvBwrD0mRl4RGrxLEVCq1JY+pawb08XYLHyWVkuaqrgUhS0QNo
        4DIB5oFXAe/imOO54IYq6wwb/9eVIWaQfOb0T3MZWozgGNROImb672c+2ZAz2kSvJbFLUQ
        aLYnKdzvEFtw2oYy2tGMfn2/OkPI2Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681486737;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bY/3sIZBuDDsO2F5msp8P1kEIGv7QfIYkVdOIXA8f08=;
        b=fE2tOeVVRdyXqvZ/DrCHL55S2rNsix5DR8IHXILzUBT5WLoOQkQQbSSvlDGU8KI71Wxy+q
        6NiSfvRMXX13UhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21C75139FC;
        Fri, 14 Apr 2023 15:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YHw1B5FzOWQXSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Apr 2023 15:38:57 +0000
Message-ID: <c49c2984-10a3-de8e-c12b-9a3833270a11@suse.cz>
Date:   Fri, 14 Apr 2023 17:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [ANNOUNCE] v6.3-rc2-rt3
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230314170502.OHw1_FK3@linutronix.de>
 <20230314171231.jwtham4a@linutronix.de>
 <9ee941ae-ae22-f14b-4e69-f81b29bbba4b@arm.com>
 <87ttxiefpd.fsf@jogness.linutronix.de>
 <73b5657a-4c47-980a-e709-cd6a880c067c@suse.cz>
 <87pm86ece2.fsf@jogness.linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <87pm86ece2.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/14/23 17:01, John Ogness wrote:
> On 2023-04-14, Vlastimil Babka <vbabka@suse.cz> wrote:
>> Is it perhaps a similar situation to this thread?
>>
>> https://lore.kernel.org/all/20230412124735.GE628377@hirez.programming.kicks-ass.net/
> 
> We are dealing with a spin_lock() inside a raw_spin_lock() section. The
> legacy console drivers do this. The fix is the new atomic/threaded
> consoles. For CONFIG_PREEMPT_RT a workaround is implemented so that the
> legacy consoles avoid this. For !CONFIG_PREEMPT_RT you can expect
> CONFIG_PROVE_RAW_LOCK_NESTING to cause a splat on that printk().
> 
> Or perhaps that particular printk() in cblist_init_generic() should be
> changed to printk_deferred() as a temporary whack-a-mole
> workaround.

What I meant that in the linked thread a solution seems to be forming in the
form of annotation for lockdep/CONFIG_PROVE_RAW_LOCK_NESTING to make it
aware that on CONFIG_PREEMPT_RT the problem it sees is side-stepped so it
shouldn't warn about it on !PREEMPT_RT, and maybe that solution could be
used for the printk issue as well (I admit I didn't check the code, just by
reading your mail it sounded very similar).

> John Ogness

