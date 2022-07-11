Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23187C43334
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Jul 2022 17:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiGKRcw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGKRcv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Jul 2022 13:32:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AAB61D85;
        Mon, 11 Jul 2022 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IKqtYuP3772AWhdPEwSolwbaEJNh5Kyl/a398AmbV1w=; b=1VXB/b8e3Fg9TNR/6sctYNCKiD
        phXZB8UZWum9R7Q7eVbf3e4yAg4OK4uN3Fi8f2iAXI5PUQ9nySx7plNQJ4Z5NPZPSK023g+DzpH7R
        sWP5SdQzZwqieRIGT4nLZMQo6FDnMxivRSCagIeImsJTp8Mz4M2UDwOyu6n2mKSeaD4PyfS5ksPzh
        OITgsIE09m4C8UC9jN2OGJ6AJ5LS38O79SkCajZby1gDXWCBOEpP9Ic2uqhv3YIcfBku17G0VIwpu
        wJv1jMK8zdvHh5ESjP2oIlFyG54wthWFHbY6z3RQ4fC154rf3C9RnT0ApvlIhGu8T9s9QXsTNmX/Z
        2AKjL5Ng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAxGt-003Vdh-5t; Mon, 11 Jul 2022 17:32:35 +0000
Date:   Mon, 11 Jul 2022 10:32:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     rostedt@goodmis.org, cl@linux.com, pmladek@suse.com,
        mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org, tglx@linutronix.de,
        adrian.hunter@intel.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 -next 1/1] module: kallsyms: Ensure preemption in
 add_kallsyms() with PREEMPT_RT
Message-ID: <Ysxes81GjdNK3yE+@bombadil.infradead.org>
References: <20220711171719.1244255-1-atomlin@redhat.com>
 <20220711171719.1244255-2-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711171719.1244255-2-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jul 11, 2022 at 06:17:19PM +0100, Aaron Tomlin wrote:
> The commit 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
> under PREEMPT_RT=y, disabling preemption introduced an unbounded
> latency since the loop is not fixed. This change caused a regression
> since previously preemption was not disabled and we would dereference
> RCU-protected pointers explicitly. That being said, these pointers
> cannot change.
> 
> Before kallsyms-specific data is prepared/or set-up, we ensure that
> the unformed module is known to be unique i.e. does not already exist
> (see load_module()). Therefore, we can fix this by using the common and
> more appropriate RCU flavour as this section of code can be safely
> preempted.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

Thanks! Queued up!

  Luis
