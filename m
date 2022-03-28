Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A2C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Mar 2022 16:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiC1QZZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242045AbiC1QZY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Mar 2022 12:25:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CE821248
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Mar 2022 09:23:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w4so21114509wrg.12
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Mar 2022 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4SOVrHfvwpfoTc9w986SuuZFZSkecgY3FuUAKkmu1I=;
        b=AWnvCcoTWwNNyreu41qxBfO9VPRTlGzGeEuy9L1scPRK0qdqmA9W8HQLNTi7/OkwZ7
         +omfSz/Ni0dXkSbDZpyXwe9HW/fVpsybTwxZmYE2DqVwAWPlEL9/TSE+Pq+o3BCOZNNL
         0vJXM1swwGLihT8ihwrqvP25E9dTGRBgAuhgL9SRaXFaLspJ/vmGfbItDBPfkND01Lc9
         soV1bkm5ouAMIBjEIjNjB4B0CWfWJ8JlM+UHlsxjXq4UVpl4zYTbliSH+oRQfim85DHF
         nzYH6UnP9xuPJMR6HDqev7l63ORss4XHAnT63tIZot7+vZS85c6kAMhBlN8SCMf0QzDH
         x4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4SOVrHfvwpfoTc9w986SuuZFZSkecgY3FuUAKkmu1I=;
        b=Psm4eDMdP8gAKBg2ZWKG404nAaa9wpGIoL3nFOLEc5+Wv9I/cG1GFH/FlnjDWhkpn4
         umhEQjlmdj9a9nWMD07f53JERDUsRVHAGmU8ECQbW9ZDW9Czduy2HnleWgkzn22MbTDx
         Xj+61WevphPUplKC4RIm8xUSetCxB4ZnEDJrN1Mdhydaamzak1Ng4q5f/5o7Yyh78L8P
         jTxwTy+45Kj/OKuUh1+sW7Re98W1irPxfm+QgLaLdaiAIPw0j5k8uD34DNFXBLDgzP7P
         P8np3jW9guPSsYicw+taA/5t3+We5U2OThAqmUxi6zzk4MCSHt9GhMXbPlxowhPIlrvl
         Pa+Q==
X-Gm-Message-State: AOAM531emE0BPBuq4yqg//w4Ep0XJAeEW9wbZqopWjplYsxoBDHAqrS9
        cyiDPleWS2aqxi3b4R5Auvp4VneGtbc1p4JLrunhLg==
X-Google-Smtp-Source: ABdhPJybYgntcKOP8aH+2QU+179TpP3obGFDmIA0TdEhwf/VxiDyE8nkrNROayN8+QAC3gVVWodylYmVg0t+qXfBilU=
X-Received: by 2002:a05:6000:1864:b0:205:a10a:8b11 with SMTP id
 d4-20020a056000186400b00205a10a8b11mr19737339wri.577.1648484621153; Mon, 28
 Mar 2022 09:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220324025726.1727204-1-rostedt@goodmis.org> <20220324025726.1727204-4-rostedt@goodmis.org>
 <Yj4ZuJxzT1oV8zhh@donbot> <20220325161819.36de3bce@gandalf.local.home>
 <Yj7z1zaDDlyHdg39@donbot> <20220326111632.09424859@rorschach.local.home>
In-Reply-To: <20220326111632.09424859@rorschach.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 28 Mar 2022 09:23:30 -0700
Message-ID: <CAC_TJvdq8_DwkNQKE4=ypHxSv07zDv8w7_84Dw=bAePAO8P9wA@mail.gmail.com>
Subject: Re: [PATCH 03/12] trace-cmd analyze: Show how much tasks run on each CPU
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Keeping <john@metanate.com>,
        linux-trace-devel@vger.kernel.org, williskung@google.com,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Mar 26, 2022 at 8:16 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 26 Mar 2022 11:07:03 +0000
> John Keeping <john@metanate.com> wrote:
>
> > > > > +               print_time(cpu_tasks[i]->runtime, '_');
> > > > > +               printf(" (%%%lld)\n", (task->runtime * 100) / total_time);
> > > >
> > > > Is there a reason for using the CPU-specific runtime for the value and
> > > > the total runtime for the percentage?
> > > >
> > > > I expected the percentage to be the percentage of this CPU's time spend
> > > > running the task.
> > >
> > > We modify it so that each CPU has the same run time, unless there's missed
> > > events at the start (later patches), and then we change total_time to be
> > > the total time of the events on the CPU and not the entire trace.
> >
> > I think we're talking about different things here, I probably wasn't
> > entirely clear about this.  It's the numerator of this division that I'm
> > concerned about and I wonder if this should be:
> >
> >       (cpu_tasks[i]->runtime * 100) / total_time
>
> Ah, I did misunderstand you. Yes, that's a typo. Thanks for pointing
> that out. I'll go fix it.

> > > > > +       if (idle_task) {
> > > > > +               printf("idle:\t");
> > > > > +               print_time(idle_task->runtime, '_');
> > > > > +               printf(" (%%%lld)\n", (idle_task->runtime * 100) / total_time);

IIUC the idle_task->runtime works out the same as the per-cpu runtime.
But for consistency I think we should use idle_cpu_task->runtime here
as well

Thanks,
Kalesh

>
> -- Steve
>
>
