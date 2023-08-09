Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9389AC41513
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 08:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHIIRr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjHIIRq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 04:17:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB82170B;
        Wed,  9 Aug 2023 01:17:45 -0700 (PDT)
Date:   Wed, 9 Aug 2023 10:17:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691569063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5byFkB6AEl/SCO6D7dce++lzSb3+3EftvzA1txVTvgY=;
        b=X92I64+L0ZzpoiFWx0pObA41nlOqyyx2Sey7L2wkLFLznc3MUA0/+S6D4FgL9zO9npX7y1
        9OxQuIUd81wdfxIhK0jN7ZXVCdK+o6c6S6ahmel0fo5OKBC+nYzNiE6zgh+z9HjjTQCkbV
        driVvbaBhHIyRZohg6rbjUd7fiVEvamYIZPWuFUDG6gKXOIYBIflL1G5ra4PEgUmbVtrno
        HrZcsc1xB8CTipoNcAE2S8w64MKffv4hrI7Iy+88AuVlrtqYVD5x8wReUFgk5OtX/tPEDQ
        snABdV9PZzdTsvNcROQcOXfpbH1dH3McA0wLe/unFAi4zKeWSzza0/JsDuO0uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691569063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5byFkB6AEl/SCO6D7dce++lzSb3+3EftvzA1txVTvgY=;
        b=sw5Lzb9ZWTgYfnqDTyzvhlaKN4lEURUKjdmxtWiedrZ2yYHS/RmOIMbQ4PdLHmDE7phbNI
        oYxkeARO8WtPKQDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RT 0/3] Linux v4.14.320-rt152-rc1
Message-ID: <20230809081738.qhWKi8Os@linutronix.de>
References: <20230808163520.305842-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808163520.305842-1-lgoncalv@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-08-08 13:35:17 [-0300], Luis Claudio R. Goncalves wrote:
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 4.14.320-rt152-rc1.
> 
> Please scream at me if I messed something up. Please test the patches
> too.

Looks good, just a nitpick: If you add 2/3 you don't need 1/3.

Sebastian
