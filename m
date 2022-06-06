Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4DC43334
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jun 2022 07:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiFFHJg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jun 2022 03:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiFFHJ2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jun 2022 03:09:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B948ED719
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jun 2022 00:08:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so11863580pjq.2
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jun 2022 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:content-transfer-encoding;
        bh=OQGPr59BMYQnvye8l3Q99WN4IlZt+h2PZEZSuYvbZvU=;
        b=k0r5P2dF0B2kAmm/DJGstkWSXGaZj0Bn0dERd+ZcvSuIXnn1kA6j7ieFvhST+C85hv
         cDM/cBQbYYw/0V2Z48sf0DiLoy/f+fD/BGVGjwxcjjQ95cHu51avU+eY8QtcJYDs0qnO
         YQZl2D+XDK0dIf782mcaG2BpqzCSf3WBPYrzWcTHDKrRyDrkALN6nsqA6/YEj4cIvhno
         X57RwfDo0xWkgNCGvt/qAo6x/nYIZV4HD9Jv8O+6OoGm5o2pzvfMyPX2Nug5OjnUjmUK
         ElHlKRxErVV5tsL13Fj3HhR470YbKpoZxt8hDt5f/+0S9tjKpi5FjPbI8bQnvbtnKr6k
         CF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:content-transfer-encoding;
        bh=OQGPr59BMYQnvye8l3Q99WN4IlZt+h2PZEZSuYvbZvU=;
        b=43NuAX8dXLl1LbLxW2o61w87yvF62sY8RnjFWFFjtwfff6lTkUPsRn44Zdla1qQsnc
         k4QrsAgTbtxCnZ7Ncpl3f0mEcHL/V79mYypMk525CbLbj3fHueUdMZXwcqEHfjaygfIY
         OEXT5oS7mYc2Al6XOUkJtAWTulsGgKEmEIiKDypCKZmLnvwoZk0h7ug7tXdZefNhH/qt
         lcPgH1Ixi/2F8WHShQ+plPSBoCc6Sr3/qUjPzOWp1+1D4fGhhLUKtvnBKRnbjNxrBzQD
         oWNh9NrjpOBmSOqHgJnJ9OcaAInwrSWOzb+EFyLgNhxbA7E+hH0d6JXrENAzuZinJwju
         VVjA==
X-Gm-Message-State: AOAM531Me17yLNgjpj1mWnSazsDwOa/DsZ0QmN3e5nHCVdFk3bZ0+V8T
        FsyVnYwf4rdZrvGcxGrzUuxkfWd2JWU=
X-Google-Smtp-Source: ABdhPJzph/apKTnLbszjBMONrOIUiO3vXns9FEDw6udH8SUfH9tC0ETNc072hw78gx+tZdQYNyhO6Q==
X-Received: by 2002:a17:902:eb88:b0:167:7ae6:5ce0 with SMTP id q8-20020a170902eb8800b001677ae65ce0mr4993152plg.119.1654499311465;
        Mon, 06 Jun 2022 00:08:31 -0700 (PDT)
Received: from [192.168.219.128] (c-24-18-165-177.hsd1.wa.comcast.net. [24.18.165.177])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090a564700b001e2e789a128sm9352339pji.52.2022.06.06.00.08.28
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 00:08:31 -0700 (PDT)
Message-ID: <9ae1d599-4514-9c22-f5a0-7176ffe98820@gmail.com>
Date:   Mon, 6 Jun 2022 00:08:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Sharan Turlapati <shatur.linuxrt@gmail.com>
Subject: [Question] SCHED_DEADLINE behavior when HRTICK_DL is disabled
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I had a question about the task admit policy of SCHED_DEADLINE tasks 
when runtimes are in the submillisecond range (which we come across 
quite often in RT ) and HRTICK is disabled.

For the kernel to be able to keep track of task runtimes in the 
microsecond range, I notice that it uses HRTICK_DL.

If HRTICK is disabled or not supported, the kernel still admits tasks 
with runtimes in the microseconds range, and but since now we're relying 
on the scheduler tick (which is in the order of milliseconds), these 
tasks overshoot their runtime and end up getting penalized which result 
in their deadlines being pushed out.

My question is, if the kernel cannot reliably track the runtimes in the 
submillisecond range without HRTICK being enabled, should it not reject 
these tasks first up? something along these lines -

  ---
  kernel/sched/deadline.c | 15 +++++++++++++++
  1 file changed, 15 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fb4255ae0b2c..0d46ae0c92ec 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2916,6 +2916,21 @@ bool __checkparam_dl(const struct sched_attr *attr)
      if (attr->sched_runtime < (1ULL << DL_SCALE))
          return false;

+    /*
+     * If sched_runtime < 1ms, then ensure that hrtick is
+     * is supported/enabled.
+     */
+#ifdef CONFIG_SCHED_HRTICK
+    if (attr->sched_runtime < NSEC_PER_MSEC)
+    {
+        if (!sched_feat(HRTICK_DL))
+            return false;
+    }
+#else
+    if (attr->sched_runtime < NSEC_PER_MSEC)
+        return false;
+#endif
+
      /*
       * Since we use the MSB for wrap-around and sign issues, make
       * sure it's not set (mind that period can be equal to zero).
-- 
2.19.0


I notice that this check is added in userspace applications 
(https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/sched_deadline/cyclicdeadline.c#n1217) 
but it should also probably be there in the kernel as well?

I would like to know if there's a gap in my understanding or if this is 
a valid change that can be needed.

Thanks in advance!
Sharan






