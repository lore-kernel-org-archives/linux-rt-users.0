Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F513C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Mar 2022 18:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbiCNSDQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Mar 2022 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiCNSDP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Mar 2022 14:03:15 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFAB3A1AB
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Mar 2022 11:02:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61A005CDBA;
        Mon, 14 Mar 2022 19:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1647280922; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=1aJYgkpysSoUKQLGDwbHYfsUmeAY7LFrK9MuROUzRUg=;
        b=Oj4NmLWDmXyxphTj3W8zUn04hcdUpFVqUOX83zQcuPjRIm67NktQU/+KQfT0nY8AKgpYa7
        UIDp4pyBXMbwr3PMUju9V0NN2DMjgwYmDRQbUFfyaV4/R3pI+Yh4/Azfy7R+6LOap1RCdU
        xPA5zA6HMPHAUmukvlqpAZRcuOjkwB11Q7qnWgw7DnCi6ysvg/Fyv6XFPo1wWqlz9hL/uf
        PFU6Sjqk2cfBivxc8uuN0kbD1Sjk/VOyeDMi/TPHCEzxW2k6bRsSqIChq6zMZVExwZ6T51
        S/VhLUyr229/OloVhFs8RjKcJdyd0TQTk4hgLCpqMqjBQLjaY7GnygdD9mjb9g==
Date:   Mon, 14 Mar 2022 19:02:00 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Arve Barsnes <arve.barsnes@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: dirty-pipe ?
Message-ID: <20220314180200.dgp3w3clar4ruuwy@carbon.lan>
References: <2658635.4HAHC1xCac@coyote>
 <CAJjrzcUo_30mZAuWVN4W2WK=WcoFC_55_Lq5y7YxdjD37US_YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJjrzcUo_30mZAuWVN4W2WK=WcoFC_55_Lq5y7YxdjD37US_YA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 09, 2022 at 07:22:15PM +0100, Arve Barsnes wrote:
> On Wed, 9 Mar 2022 at 19:16, gene heskett <gheskett@shentel.net> wrote:
> >
> > Greetings all;
> >
> > Is this kernel vulnerable?
> > 4.19.71-rt24-v7l+ #1 SMP PREEMPT RT Thu Feb 6 07:09:18 EST 2020 armv7l
> > GNU/Linux
> 
> No, the vulnerability was introduced in kernel 5.8

And the latest release is v4.19.233-rt105, while you are still on
v4.19.71-rt24. So you are missing out of other security bug fixes for
sure. As GregKH would say: All users of the 4.19(-rt) kernel series must
upgrade.
