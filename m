Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3022DC38142
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Jan 2023 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjAWSE7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjAWSEg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Jan 2023 13:04:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699830B07
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Jan 2023 10:04:31 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b6so9589479pgi.7
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Jan 2023 10:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zi+iUdTui0eMYRh+bS6eQbXlcjJzEZc+EWZsqkgWXs0=;
        b=i2Q2SnN2NOq0NB2gvTP0FhB41NgE/wUme9MAS0qjjsaLwc8klFOiguv772mawVvnQW
         y8UosPW9CY8a6vpn5sP1miwwLOajE/uMgSfiKKtLyK9Bjz5R8WQholPJvIL8Q5VzqLWi
         Z7gtBKgGkMMgfc2GRLlkn6+mZnxqB2I0AAeg5q7cATx1WV9YVPKlkEOzSl98KUrrUnG4
         gAzE1wmK2NswL2xtr8/IxpHJhGvVPxDAZbFXZ+ZGe5GJ/0jktfEja3joiOFgBYbK4cgP
         csukWuk4IUPvh0x9abzFi+8CL40mFGeDoCXjI/iH9DK6VeWzOdHV397vyZ8xg3vITGZF
         5+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zi+iUdTui0eMYRh+bS6eQbXlcjJzEZc+EWZsqkgWXs0=;
        b=GvQREOk9ZuffUn2rYnC8LfAC0MuNvMUm+GDIWLvoqLNNF7fe/aGFxq4GxK62YcbqtD
         4uOZl7I0SwXmsnhpFR7WJvLXSh+c78/x+gSERKYfIvb1Kwohnvxn0eSf7RJ/jzaLZkKv
         nLJo/dFLNxLAhg/oaeNFTJOirXD9yNMRlKp08wOQLVq/S0j58rePSCbyu9p9N0lWc9xX
         XBbVl22V/V5JTuzzlOKWUq07pD/Qk+8mLkp5dewtYP2VExLDbnUXaS6AEYq2MkNrb++t
         pcIk7AdBvMOaPKi831bQn/DsG2lb/kxSxLmWsDTIW+qZiwcIPHlJFGVBsCIt8v72vEvK
         khRg==
X-Gm-Message-State: AFqh2kpnRimMcaLN+SF+aXyokjUWitDKv5BylSa3U1Em57V8u8WVqFXI
        WOtGb6dnQ34c9NA36VDmtaCmrgDGr6YQYIvV59ePIQ==
X-Google-Smtp-Source: AMrXdXv/iZkG4aEOY0tAm5Pe8RQpzhFSGNbe/VHOdBJlj8n/e3z2TK0jIc/xskxrsvKD/lF81sJaEsZr/n0FCDbXJp8=
X-Received: by 2002:a63:a5e:0:b0:4b4:e491:c331 with SMTP id
 z30-20020a630a5e000000b004b4e491c331mr630573pgk.19.1674497071212; Mon, 23 Jan
 2023 10:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
 <Y6H4zqr8bObRFE1g@linutronix.de>
In-Reply-To: <Y6H4zqr8bObRFE1g@linutronix.de>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Mon, 23 Jan 2023 10:04:20 -0800
Message-ID: <CAFzL-7upCjPPyB-9tHf4E4=M+GFot2fnH9t7M5x9cKikUMxB+w@mail.gmail.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>,
        Glenn Elliott <glenn@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 20, 2022 at 10:03 AM bigeasy@linutronix.de
<bigeasy@linutronix.de> wrote:
>
> On 2022-12-20 10:44:07 [+0000], Chang, Junxiao wrote:
> > Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.19-rt kernel as well.
>
> Thanks for the ping. I did see the initial email and I didn't get to it
> yet. I need to re-test, confirm and then apply.
> The ktimer patch is not in v5.15 and this is currently the latest one
> maintained by the stable team. I don't know which one will be the
> following LTS kernel but this one needs to have this addressed. The
> v5.19 is not receiving any updates.
> Given the current timing, I will look into this in January.
>
> > Regards,
> > Junxiao
>
> Sebastian

Any further thoughts about Junxiao Chang's patch?    We backported
ktimer patches from Sebastian and Frederic to 5.15 and would like this
fix  it is sensible.

Thanks,
Alison Chaiken
Aurora Innovation
