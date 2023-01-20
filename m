Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F72C25B4E
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Jan 2023 10:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjATKBV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 05:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjATKBU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Jan 2023 05:01:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238CA8A6E;
        Fri, 20 Jan 2023 02:01:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D1A9722A03;
        Fri, 20 Jan 2023 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674208877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WN+73+vvFy8jILfH+VTK0vTY7CBjJlVQddeBj5UTg2s=;
        b=E/cJC2S99Uoymz1PZp8Oqu4Ty8EsxToH1To0QwU53UbIyyrpRZtoeqeEv6eXK5vIrcoP0K
        Fzit4eQEK4CtUbezR62w0B/y82kg1sNoH9DpuN6hDhCaVwkH6R8cLdoyps7C9PzIh2oG0a
        OZfqa0WqYhQOG8Bix02g2kotpjBgev0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674208877;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WN+73+vvFy8jILfH+VTK0vTY7CBjJlVQddeBj5UTg2s=;
        b=klHr6JVsQj37PCsVHHV7Q0UdQfA1ErT9+O7CCPUw190tBqVwnbGnJKImu9QlWp8iZwuofA
        g0rmRsrNOP4ZnYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF5C51390C;
        Fri, 20 Jan 2023 10:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +7meLm1mymNXRQAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 20 Jan 2023 10:01:17 +0000
Date:   Fri, 20 Jan 2023 11:01:17 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Pavel Machek <pavel@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Message-ID: <20230120100117.desy327bamo7khrv@carbon.lan>
References: <Y8VSslRJZpFbo1/u@uudg.org>
 <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
 <Y8krsVFguwWLy+zT@duo.ucw.cz>
 <Y8lCspFtQ0wg6uCy@uudg.org>
 <Y8mwF0m+M1+e/fz/@eldamar.lan>
 <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk>
 <Y8oNTkUVDr7iQWzp@uudg.org>
 <c427d686-c850-4195-011b-93f51faa176d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c427d686-c850-4195-011b-93f51faa176d@kernel.dk>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jan 19, 2023 at 08:49:28PM -0700, Jens Axboe wrote:
> I do wonder why I didn't see this in testing - the kernel build bot was
> also happy with it... But anyway, should be an easy fix.

This is caused by the RT patch set, so you wouldn't see it without all the RT
patches applied :)
