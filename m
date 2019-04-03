Return-Path: <SRS0=QAP4=SF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629DCC4360F
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Apr 2019 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F36520700
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Apr 2019 13:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPwYC1ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDCNxL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:53:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36520 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNxL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Apr 2019 09:53:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so8385617wml.1
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Apr 2019 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fdTfuuQU65xn1x6K8g6RDIUL/5h5c8xtNEswF7JIXbQ=;
        b=BPwYC1agIE8y3zLXmYPUSDAVPxWpEoyckPNwiST6a4JZSLwQ3rgAUjstwEZhosDKj5
         QklISJXLmBuscHgR2KsbMzNkVwicMGlhKK7izT+XQpL8LxD8aZhGh/BckOJqQMsV8AUH
         9gmQqcx7GogoRBPwlGmdd8ghEk40AL/V29TbxsoLNXX2m/AFhfibZyTLNc/64dL3B/d3
         n+fH5mNAz2xhdpOt3HCAVlUiJHVD+N7BgaEQfxMfHVtkih2ap8f/WC9I/FCMd6Vu98fE
         SX+rTCkPzgbhOnNUbP5nR1cO/Pj2vl5wb/9CLpvwKG35BkWMBJGYo/eQTC51x0KCww4h
         ZmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=fdTfuuQU65xn1x6K8g6RDIUL/5h5c8xtNEswF7JIXbQ=;
        b=DTnBHQmkPW9LIZlNMHpB+XTB7ICiH7iV+FCDPrRAD6ernK9CuEi2zOommIBYYbI4oc
         exW/xBbXAj27OjVRXfggfP3TM3BDgpepSHF8/p0w2e+BNBKoVq5u5yNg1c8kY6BakRnJ
         PmT985lkgrD8hwLwoXYA4cxXSFzlEKPXvVQ2sLSEiOTzmYtuvUqjIxLcEiZ1ip1qoD4Y
         xacIynhIugQ2J5q4tLJIqa6WlytnLwPcXnY3NA3PuMrj6+LzKJqwRQw/fdULU+Xhw/BQ
         US9TSfj7f0kltL8CIsZOnMp67g/V496D+Eab99GCGbY6PeBn8OxXMj9+2NeI+/IUigiW
         pACg==
X-Gm-Message-State: APjAAAWzEBASOl8NI+hHoKSrEh8LfgePtvBCch5hFhyFuQBincRviFdp
        UIlZnHpuZtC+OgPhG+AQpyA=
X-Google-Smtp-Source: APXvYqwgdNQUrrUFPYySPmBNftD3TJvtIDVPwDs1ju6FXyR0dYh4TLlrh//WZ9v07IRAPYhQ6f8LsQ==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr53531wmc.1.1554299589348;
        Wed, 03 Apr 2019 06:53:09 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id w16sm20616633wrt.84.2019.04.03.06.53.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Apr 2019 06:53:08 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:52:58 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rt-tests: cyclicdeadline: fix getopt string
In-Reply-To: <20190402094239.21482-1-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1904031552220.5546@planxty>
References: <20190402094239.21482-1-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 2 Apr 2019, Kurt Kanzenbach wrote:

> There is code to parse the interval and step parameters from the command
> line. However, these options cannot be set, because the getopt string is
> incomplete. Adjust it accordingly to make '-i' and '-s' work.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 761f8d7d7483..08460107c464 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1062,7 +1062,7 @@ int main (int argc, char **argv)
>  		exit(-1);
>  	}
>  
> -	while ((c = getopt(argc, argv, "+hac:t:")) >= 0) {
> +	while ((c = getopt(argc, argv, "+hac:i:s:t:")) >= 0) {
>  		switch (c) {
>  		case 'a':
>  			all_cpus = 1;
> -- 
> 2.11.0

Signed-off-by: John Kacur <jkacur@redhat.com>
