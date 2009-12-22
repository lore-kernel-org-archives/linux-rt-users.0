From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/4] Fixed missing parsing of short arguments in
 classic_pi
Date: Tue, 22 Dec 2009 21:50:36 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0912222145010.8838@localhost.localdomain>
References: <1261496858-12744-1-git-send-email-davids@redhat.com> <1261496858-12744-2-git-send-email-davids@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: David Sommerseth <davids@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22674 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbZLVUuk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2009 15:50:40 -0500
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBMKoeEZ027585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2009 15:50:40 -0500
In-Reply-To: <1261496858-12744-2-git-send-email-davids@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 22 Dec 2009, David Sommerseth wrote:

> Signed-off-by: David Sommerseth <davids@redhat.com>
> ---
>  src/pi_tests/classic_pi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/pi_tests/classic_pi.c b/src/pi_tests/classic_pi.c
> index 59e907b..2b8ef3d 100644
> --- a/src/pi_tests/classic_pi.c
> +++ b/src/pi_tests/classic_pi.c
> @@ -198,7 +198,7 @@ int main(int argc, char **argv)
>  	setvbuf (stdout, NULL, _IONBF, 0);
>  
>  	/* process command line arguments */
> -	while ((opt = getopt_long(argc, argv, "+", options, NULL)) != -1) {
> +	while ((opt = getopt_long(argc, argv, "vqni:", options, NULL)) != -1) {
>  		switch (opt) {
>  		case '?':
>  			usage();
> -- 
> 1.6.2.5

David

Thanks - I fixed-up your patch to put back the leading '+' or else you 
change the behaviour when a non-option is given between two real options.

We have been actively maintaining pi_stress, but classic_stress is a proof
of concept, so I don't know how much longer we want to maintain the code
here.

I pushed your patch with my modification to
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch: rt-tests-dev-new

Clark please pull above.
>From 2e2c1eb6ae2147ae68f1af4a0cc90066ad3c4bd0 Mon Sep 17 00:00:00 2001
From: David Sommerseth <davids@redhat.com>
Date: Tue, 22 Dec 2009 16:47:35 +0100
Subject: [PATCH] Fixed missing parsing of short arguments in classic_pi (David)
 - Added the '+' back to the arguments (John)

Signed-off-by: David Sommerseth <davids@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/classic_pi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pi_tests/classic_pi.c b/src/pi_tests/classic_pi.c
index 59e907b..91a8d6a 100644
--- a/src/pi_tests/classic_pi.c
+++ b/src/pi_tests/classic_pi.c
@@ -198,7 +198,7 @@ int main(int argc, char **argv)
 	setvbuf (stdout, NULL, _IONBF, 0);
 
 	/* process command line arguments */
-	while ((opt = getopt_long(argc, argv, "+", options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+vqni:", options, NULL)) != -1) {
 		switch (opt) {
 		case '?':
 			usage();
-- 
1.6.0.6

