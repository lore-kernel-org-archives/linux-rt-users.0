Return-Path: <SRS0=D0cg=RJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD55C43381
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Mar 2019 16:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488C320840
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Mar 2019 16:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="K4E5Pm7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfCFQfd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:35:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42681 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfCFQfc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Mar 2019 11:35:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id i5so11290422oto.9
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Mar 2019 08:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foh1KeCRhfMylUuRDzfDprJeF5O+H3d0DU7HYjOcXk8=;
        b=K4E5Pm7KZyz8SdpPtqPCFgcwK6u1PWJSezWdpIOfuoovj51j5Q8Xe9T2p6vs+uih7G
         +rhy0aCfE81hZax3MaD+jHhZPJqNN5v5y3Y+W1QpWOm5S0VjJ2khP1GMDWYoUmr9+UHB
         V1kmIMhRwrQSw6tK4Z+BPzwvU684/q6xRPt45xHD7SH5M5ngl7IRuduuiaMn7oaGCliJ
         q8bKDsJXNra7kudCwFUSeR0ShPUAy84v7F6qGoy3Tp9hDL20JPU43/M1UnWwrk6+wNri
         Tcn3GiRdva+KJTsyjomRXAVIdl9zPzNFfXJsfnZ+fPK2ZTOX9uDyWU6kMOZROhA0OXgS
         GG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foh1KeCRhfMylUuRDzfDprJeF5O+H3d0DU7HYjOcXk8=;
        b=QrC0m3xp/doYgkpWEAR7CmE5fgl95yaeKMy2tvaHw2QwQMeqOp/WRPDNS+AzuJJlHP
         VUI6yjV1+PyCWBs2kyraDZL27I6wlhLcLzqFVO5j6SEQf2g/aVjYNFZB/voJId0lMFnW
         yOaq7Ed2IeihPGHFJ5VaVPeH32ANmfKf118dx2tQ63YasEGtLwvznQVWwsPOF8XZKtdw
         BxgjuQrsVjr6yG2FigmCmSHm9ep3WcTZEUZz1xpMDo3WqO3KsUWeztrs+e30KPCxNEBz
         rgNhKokH44PbtINByRaeGUoGhmqhMiV64f2V6dFMOuxXt6Un5BZ6ibbcYHYtP4EJmk1y
         +SGQ==
X-Gm-Message-State: APjAAAUaq912+L7lRImF3BQchylpJB9h9ZPLA74sqTBJig1quZF36fK6
        GX7bt/IuOt1V8g7QtsSS6qECNn9j2KZswzh8YKMxfg==
X-Google-Smtp-Source: APXvYqzTxZpXdUJ9hOx3g8oxM40WfEMJOBbMHcA0ByjOUxR5Uv8dxYtnvkjq0guIm9zhbA/IX9nRPWudMVOeY0lLbYo=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr5216791ota.214.1551890132048;
 Wed, 06 Mar 2019 08:35:32 -0800 (PST)
MIME-Version: 1.0
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
In-Reply-To: <20190306095709.23138-1-yongxin.liu@windriver.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Mar 2019 08:35:21 -0800
Message-ID: <CAPcyv4h7a8QSvJiUqCd=r3KPaWwiPC_-9x3Jip6eY2XGJ5Wc0w@mail.gmail.com>
Subject: Re: [PATCH RT] nvdimm: make lane acquirement RT aware
To:     Yongxin Liu <yongxin.liu@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pankaj Gupta <pagupta@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 6, 2019 at 2:05 AM Yongxin Liu <yongxin.liu@windriver.com> wrote:
>
> Currently, nvdimm driver isn't RT compatible.
> nd_region_acquire_lane() disables preemption with get_cpu() which
> causes "scheduling while atomic" spews on RT, when using fio to test
> pmem as block device.
>
> In this change, we replace get_cpu/put_cpu with local_lock_cpu/
> local_unlock_cpu, and introduce per CPU variable "ndl_local_lock".
> Due to preemption on RT, this lock can avoid race condition for the
> same lane on the same CPU. When CPU number is greater than the lane
> number, lane can be shared among CPUs. "ndl_lock->lock" is used to
> protect the lane in this situation.
>
> This patch is derived from Dan Williams and Pankaj Gupta's proposal from
> https://www.mail-archive.com/linux-nvdimm@lists.01.org/msg13359.html
> and https://www.spinics.net/lists/linux-rt-users/msg20280.html.
> Many thanks to them.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Pankaj Gupta <pagupta@redhat.com>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
> Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>

Looks ok to me in concept.

Acked-by: Dan Williams <dan.j.williams@intel.com>
