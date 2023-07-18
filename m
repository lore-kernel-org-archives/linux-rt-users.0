Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCD5EB64DC
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jul 2023 15:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjGRPsB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jul 2023 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjGRPr6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jul 2023 11:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA959E
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Jul 2023 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689695231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=480NlqUGmbq+n+c1X09ptFbsDhIT60LlAtLVYgmyiVo=;
        b=fJaPaIUe66DiZIpcgelicoRLjUAj+Og8v1TxA0UkIeedHMq7vuxzaJALDiAnvjpiHrQR5Q
        BASwzi+r+mePzxXJFvWy3TqbbXnsOK9qmCL3no/jG58Lxzi2U3+kLJRd9wvjSFhz5EcIYc
        5VB8YANSzvwCXcTfaVgfJLj1ybVX1w0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-rU7fkIXfPN-8bk23qsVxjA-1; Tue, 18 Jul 2023 11:13:44 -0400
X-MC-Unique: rU7fkIXfPN-8bk23qsVxjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A1D42800619;
        Tue, 18 Jul 2023 15:05:34 +0000 (UTC)
Received: from localhost (unknown [10.22.34.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03B4E2166B25;
        Tue, 18 Jul 2023 15:05:33 +0000 (UTC)
Date:   Tue, 18 Jul 2023 12:05:33 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     =?iso-8859-1?Q?Andr=E9?= Pribil <Andre.Pribil@hms-networks.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [preempt-rt] BUG: 4.14 patch uses CONFIG_PREEMPT_RT
Message-ID: <ZLaqPZ5KGJyV40eI@uudg.org>
References: <AM5PR10MB1620935083DA304465514B0DBD36A@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR10MB1620935083DA304465514B0DBD36A@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jul 12, 2023 at 10:16:57AM +0000, André Pribil wrote:
> Hi,
> 
> I think there is a flaw in the current preempt-rt 4.14 patch (probably since v4.14.302-rt142).
> 
> The "0515-timers-Prepare-support-for-PREEMPT_RT.patch" uses at two location the 
> following configure option:
>   #ifdef CONFIG_PREEMPT_RT
> 
> I guess that "CONFIG_PREEMPT_RT" is not defined for the 4.14-rt kernel and should be 
> "CONFIG_PREEMPT_RT_FULL" instead, or?

Thank you for spotting this!

I will soon release a RC with the specific change you mentioned and the
backport of this commit from v4.19-rt that has been in my list for a while:

    67821680a2b8 rt: PREEMPT_RT safety net for backported patches

Luis

> The problem that I was facing was that a tcdrain() call from userspace was spinning forever.
> I traced this down to an endless loop in del_timer_sync().
> After replacing "CONFIG_PREEMPT_RT" with "CONFIG_PREEMPT_RT_FULL", the problem
> seems to be fixed.
> 
> Regards,
> Andre
> 
---end quoted text---

