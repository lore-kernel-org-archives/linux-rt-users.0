Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140FF2DE1E6
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796892; cv=none; b=p0VOtNUnGyqkZIh3H6n7oEVGaKmizpoHMDsDGDHsb9YtXfdhPhFArwvKmYOmPDLM9a406AeS42aYm2JE5cls882Vh0ZQMTH2KRWSkY4L3w+y4uKTbJsrov3RgXs+0BjzAYF84WECZGzSfX3Z5nE/dxDJvQceSIj9k0VtQZBAj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796892; c=relaxed/simple;
	bh=xYRP6YygDAJ2MS3g00oCpidHP0VnwjKZy5lY3N9fIPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbA3YkGv1lPIGC6ZEqNFjIrigjCWz08U6/NOz4SPEbvPzmMTq6qmwCje71EFjUG53N82PnYy8QYe7c0PCLAe7Ti+Lnc+OFbmMiei+aFgnPWVZTuyyEbgfMLDCtCxUweBsBScaeo1/p5kVX2DE3PkVv+4nPJofO5giHn+IiRnbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E22C4CEF5;
	Mon, 10 Nov 2025 17:48:11 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:48:09 -0600
From: Clark Williams <williams@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [stalld v2 3/6] Makefile: Explicitly run the 'test' target in
 the tests directory
Message-ID: <aRIlWQsegOkUY1gW@lysander>
References: <20251110132241.43685-1-wander@redhat.com>
 <20251110132241.43685-4-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132241.43685-4-wander@redhat.com>

On Mon, Nov 10, 2025 at 10:22:38AM -0300, Wander Lairson Costa wrote:
> The 'tests' target in the main Makefile was invoking 'make' in the
> 'tests' subdirectory without specifying a target. This relied on the
> default target in the tests/Makefile, which is not explicit.
> 
> This commit adds the 'test' target to the make command, making the
> build process clearer and more robust.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 23e786d..619413f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -183,7 +183,7 @@ static: $(OBJ)
>  	$(CC) -o stalld-static $(LDFLAGS) --static $(OBJ) $(LIBS)
>  
>  tests:
> -	make -C tests VERSION=$(VERSION) CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"
> +	make -C tests VERSION=$(VERSION) CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" test
>  

How do you feel about adding a 'sudo' to the make invocation, either
here or in the tests/Makefile?

If you don't then the tests run and all pass. If you run it as sudo you
find that there are still a couple of failures. 

Clark
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
