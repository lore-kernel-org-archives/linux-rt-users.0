From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: remove compatibilty hack for old libnuma,
 repairs "-a" for isolcpus
Date: Wed, 20 May 2015 16:38:25 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1505201629400.7867@riemann>
References: <20150427125846.1de46037@sluggy> <1432126711-18618-1-git-send-email-henning.schild@siemens.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-303362576-1432132706=:7867"
Cc: RT <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@gmail.com>,
	"Gary S. Robertson" <gary.robertson@linaro.org>,
	Clark Williams <williams@redhat.com>
To: Henning Schild <henning.schild@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34776 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbbETOia (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 May 2015 10:38:30 -0400
Received: by wghq2 with SMTP id q2so55243362wgh.1
        for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2015 07:38:28 -0700 (PDT)
In-Reply-To: <1432126711-18618-1-git-send-email-henning.schild@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-303362576-1432132706=:7867
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 20 May 2015, Henning Schild wrote:

> Recent versions of libnuma >=2.0.9 all have numa_parse_cpustring_all(). Not
> using this function will make the parser fail if isolcpus are used.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  src/cyclictest/rt_numa.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index 06c9420..64516f5 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -92,17 +92,7 @@ static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
>  static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
>  	int max_cpus)
>  {
> -#ifdef HAVE_PARSE_CPUSTRING_ALL		/* Currently not defined anywhere.  No
> -					   autotools build. */
>  	return numa_parse_cpustring_all(s);
> -#else
> -	/* We really need numa_parse_cpustring_all(), so we can assign threads
> -	 * to cores which are part of an isolcpus set, but early 2.x versions of
> -	 * libnuma do not have this function.  A work around should be to run
> -	 * your command with e.g. taskset -c 9-15 <command>
> -	 */
> -	return numa_parse_cpustring((char *)s);
> -#endif
>  }
>  
>  static inline void rt_bitmask_free(struct bitmask *mask)
> -- 
> 2.3.6
> 

This is a terrible hack, but I'm afraid to remove it yet.
Even systems as recent as Fedora 19 have a libnuma less than that.
pm -qf /usr/lib64/libnuma.so
numactl-devel-2.0.8-4.fc19.x86_64
[jkacur@riemann rt-tests]$ cat /etc/fedora-release 
Fedora release 19 (Schrödinger’s Cat)

This is causing problems for people who want to pin threads to 
CPUs isolated with isolcpus=, so we do need to do something about.

I could perhaps accept an improved hack that tests whether the hack itself 
is needed, until we have a better solution.

Thanks

John

--0-303362576-1432132706=:7867--
