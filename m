Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC99C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDAB22B3B
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbhAZRTb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbhAZGad (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:30:33 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F2C061573
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:29:52 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id k193so14995738qke.6
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=c9uNPgCLCbY+/N1hyKSq6kmxKghp7gmq6MEOfDgm50w=;
        b=sXcdYWVlzE+L//OmEP4c1Fffy4NXqU9WTGOEENg9VDY1HMfgZRMLNx2hSAwU+AWC26
         XPQCinx8klFjl8eEViDuPQIZOw0oSzdzHOBt0pQ6oTFwRzY/mLw9tSKIpmXIVASSiZbD
         FEm/Wtd/fYp9NrQfsjyONpeFA7eE97wUKNSpFOcKKnBdfCEyikx+ZHi1nJsVwATfv4PJ
         /EALXEMG86Vd0MqUEKD8JYBBCPMcznr4XbQaL6/tzwnwthykRoQZ/UZKsC2NDyCxjbaa
         NGkxA5k02Quf2Vab7ZDalCRC5sa2F9Qnu3WrTo1IoAlrXjLDdw2HA/w2e00ykyPuLcpi
         4fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=c9uNPgCLCbY+/N1hyKSq6kmxKghp7gmq6MEOfDgm50w=;
        b=oLjYMQywBSg8yQE0u/AzJf3qDItghR4TuSuNW4gHCrReKGFNiI/YEQRpIjrAaJTmi7
         J/UYg3OaMzXIqYMHt4qPgN/YIxY7gkjLjXhZ0E2ACfEk+QLrJeIGvgLqZaqBeKe2DIJP
         LnGDxbdcJBG8nfG9w3zLeHS0pnej7xHLSoIAN/+bSsXCcIfMbdbImvZVFgb3G1uklNaP
         yKbs0+Hl0vYs/DcFdC2PhvUAf2UfDAPImz0bsmZ0qwweSUxDvWousTf+EteiUHpsRxIO
         daavh9GjzcimYnZyyMcYT71B0GEtj8pKHofRI6K9SUJq0cESR2wd/jDqA4LmQ+z9JJnD
         5Ltw==
X-Gm-Message-State: AOAM530OZ73y1l2jJfhixFx+eDz9HfApr2DaCrKSSnhFRRjFfH3MkwCL
        5ay3V//esCfLc+X+RrsG7/0=
X-Google-Smtp-Source: ABdhPJyKMFcTnN1UNLDbcAhE3Jmw0XfRXtJiWW+fR3u3LG4cpmERmslFimG4qCVCkUHzWb/H1DfdOQ==
X-Received: by 2002:a37:be04:: with SMTP id o4mr4396044qkf.336.1611642591437;
        Mon, 25 Jan 2021 22:29:51 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id q6sm13419224qkd.41.2021.01.25.22.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:29:51 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:29:50 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 07/20] signaltest: Always use libnuma
In-Reply-To: <20201218161843.1764-8-dwagner@suse.de>
Message-ID: <db225991-c58d-3c2a-ce85-23bc95a0c14b@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20201218161843.1764-8-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> libnuma is hard dependency for signaltest. Thus we can always call
> numa_initialize(). This allows us to remove the global 'numa' variable
> to track if libnuma has been initialized or not.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/signaltest/signaltest.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 918d2ab98f6e..b3a82f8c4f65 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -206,7 +206,6 @@ static int quiet;
>  static int lockall;
>  static struct bitmask *affinity_mask = NULL;
>  static int smp = 0;
> -static int numa = 0;
>  static int setaffinity = AFFINITY_UNSPECIFIED;
>  
>  /* Process commandline options */
> @@ -214,6 +213,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  {
>  	int option_affinity = 0;
>  	int error = 0;
> +	int numa = 0;
>  
>  	for (;;) {
>  		int option_index = 0;
> @@ -242,8 +242,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  			/* smp sets AFFINITY_USEALL in OPT_SMP */
>  			if (smp)
>  				break;
> -			if (numa_initialize())
> -				fatal("Couldn't initialize libnuma");
>  			numa = 1;
>  			if (optarg) {
>  				parse_cpumask(optarg, max_cpus, &affinity_mask);
> @@ -298,9 +296,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  
>  	/* if smp wasn't requested, test for numa automatically */
>  	if (!smp) {
> -		if (numa_initialize())
> -			fatal("Couldn't initialize libnuma");
> -		numa = 1;
>  		if (setaffinity == AFFINITY_UNSPECIFIED)
>  			setaffinity = AFFINITY_USEALL;
>  	}
> @@ -354,6 +349,9 @@ int main(int argc, char **argv)
>  	int status, cpu;
>  	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  
> +	if (numa_initialize())
> +		fatal("Couldn't initialize libnuma");
> +
>  	process_options(argc, argv, max_cpus);
>  
>  	if (check_privs())
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
