Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C86C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925D86145E
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhEGQrG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbhEGQrF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:47:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E35C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:46:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i67so9084936qkc.4
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=FweovsYq6Lk5ph4esUEEb4XVPmmtk64fKs2z/ckZ9J4=;
        b=uCtwwoB93XYF+rI5X6kQ2L9PmSnXgJ+UKHGs8dsodSM975Rl4jXJ9acprtpAH0J5IY
         O9pl5E/tvoXF1TdDYOmp/nJSubWK4UxZLmLXqvkfvbBGPjQyjnfGLmYoZb6OVLE5HBS0
         p1YsZ4o60xImkKqtI8jPgwUORN5GjkQfGAMXByrlIVAEdrgSfzKrKyqLSEuDk4ov6v+H
         9mBJIC9cZp8HxlDyJp8p8qxH6djdDl5f5mHOPkS8IclA5Rr8b9bNL9NwFfAa84BrnRo7
         mpm+HAXCv0pp+fK5J/pQOhhht2gv/idaKBQ7S0wycOotXih+Pj9ixhYVhqg8rAVMGWRA
         Qo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=FweovsYq6Lk5ph4esUEEb4XVPmmtk64fKs2z/ckZ9J4=;
        b=BsMZ/9z63XhNSOCf8Et1gafZ7ABvVfsqRMz2u/34aOZck3HgJ3YFVbMEqNErBBiei0
         RMfrOmcowg/PvUgldBIV8XmOeNCekLcbLV2dn4NAYbH1LEwmryP8qj2a/X3lmMnvrqs0
         /lVxfDWxT2jh245mDOuN+zBRwanJnnR8sY+M3Uc3EeQMipZHwzIaOMc1VUQzq8ETFxrq
         OeZ2fRxOXlUAj6chJHTsQhekuJ0JF8bVsE0Y792j/sXhjxnXmySZ3RV8e/Z2zg7j1LEk
         ygQTJXEqr5bOj10LUHYDVImFxJXgRCnDI8yB8+ctq88VH0iRnIUteJJnHj+FnRJ4N0YU
         XO1g==
X-Gm-Message-State: AOAM530IhBkJVdaOYyvex0dsj8JmPW63FHczo6mCs+rDONuousKZnRek
        uqxYi+thtRe2TY/Upyh9I7Y=
X-Google-Smtp-Source: ABdhPJxrypWWokloIqhnNBNQj1MyothiFbN/nPBjxh8NIK1LtEobxhOL+PZwMERVlikIkmd3qElSQA==
X-Received: by 2002:ae9:edd5:: with SMTP id c204mr2293785qkg.176.1620405964530;
        Fri, 07 May 2021 09:46:04 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id l4sm5213341qkd.105.2021.05.07.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:46:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:46:03 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 23/33] sigwaittest: Record start of test
 execution
In-Reply-To: <20210320183829.1318-24-dwagner@suse.de>
Message-ID: <f941ee13-3c5a-d591-3750-e8881bdd4@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-24-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Use rt_test_start() to record a timestamp when the test starts.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sigwaittest/sigwaittest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 142419f9e315..6e8bc7b50d5f 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -652,6 +652,7 @@ int main(int argc, char *argv[])
>  			    &sender[i]);
>  	}
>  
> +	rt_test_start();
>  	while (!mustshutdown) {
>  		for (i = 0; i < num_threads; i++)
>  			mustshutdown |= receiver[i].shutdown |
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur@redhat.com>
