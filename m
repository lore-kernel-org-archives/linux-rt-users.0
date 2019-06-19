Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F39DC31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652A3217D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHZWIE5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfFSPto (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:49:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46558 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSPtn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 11:49:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so3881359wrw.13
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Jun 2019 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=L7FMr3yjeJrlPptlwqEzE51ADJIeiUMkJIC79u39lBM=;
        b=QHZWIE5MiVNdfH8EVxZrzxxqF5WAnc2zB6NK2WnECboO17vgyd0gebl0T4Q/TB1cbr
         whp/aKjNv+gvz2NASg66WsbLUXbEBebZDTz/ZPDAcY9fGsRgCQsjkeafAQnXbmqDkQfh
         mP3PefA6c4RVitxfVLLpYiJcuyMEb5rNOUynAUuEDiaSJ4/B5Cv3ep1TUsutcCGXCedk
         yoabTpqrL3h4rGtFRjK5ywiVQCREeF6k+eKmZlUIgusnxTBwdvQkw+XNv2hWAwaPLlSp
         ZpGmfSm3k7vJrpv7EoFnTgE4XqxzKD2R/8WGLRi38ePKlJrJqIExdO8chXHRV5q2yvB2
         rdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=L7FMr3yjeJrlPptlwqEzE51ADJIeiUMkJIC79u39lBM=;
        b=W+6DhvJ0KtY6QO8iRPqNPIUdEEpcuio3uPEjpCGMBbHpPUzDRELJqlC8emTEFQM0Lk
         BJXeAHiqSQYBYmSzj9iivmYIBY18I5tIH83tmhgYeAEEmQ1GGBQtrbBCbss620Fo/XJe
         cgx2XQ/WUvT0fW6+f4YgPcdAp0mnkYgL/3diFAg17DuxRLJrvXhv6HtzLl4SrKYrLGpf
         SdhSbplkU+amrvI0qc25GKbcx55B4jzqSXCnXXqmVTNxhtVh3nx89JXe3scesF5TK+vs
         aMkZIwPhlx0srW2UY9XQtC8hqtxoYZBfNzz98u3zXcS8ll2MqOdMBo5L3F70Hr/yFHa7
         a5yg==
X-Gm-Message-State: APjAAAUirNRO+QZtDrWtj7ghYa2Or8P/vJxEvY+qApWAnwS2EoSnexIY
        ZOJGAhbHjhgXeSiMS8AjqSo=
X-Google-Smtp-Source: APXvYqxeyOBu9bpCTRqxNoIZlX/bbWCFdoGi498vTJFFixObMyoW3dzpXHN5ANscstfaxfvkbKEARA==
X-Received: by 2002:a5d:6742:: with SMTP id l2mr24970833wrw.323.1560959381727;
        Wed, 19 Jun 2019 08:49:41 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id z5sm1084767wmf.48.2019.06.19.08.49.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 08:49:41 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:49:39 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 6/6] rt-tests: cyclicdeadline: Fix cgroup setup
In-Reply-To: <20190618103841.27249-7-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1906191749250.12022@planxty>
References: <20190618103841.27249-1-kurt@linutronix.de> <20190618103841.27249-7-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 18 Jun 2019, Kurt Kanzenbach wrote:

> Deadline tasks cannot be pinned to specific CPUs by using affinities. Cgroups
> have to be used instead. Cylicdeadline has code to do so. However, that code is
> never executed, because the all_cpus variable is reassigned after argument
> parsing. Remove it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 16d986a02244..7b5e8b36c4ea 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1165,7 +1165,6 @@ int main (int argc, char **argv)
>  		exit(-1);
>  	}
>  
> -	all_cpus = 1;
>  	if (!all_cpus) {
>  		int *pids;
>  
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
