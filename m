Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2134B1B8
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068718; cv=none; b=grKg2qCmE7I7yVGbTZRhFWVjXaPLUmS14PdWgHWrlyyw58wOzV9fGxJnwwH+v+S1s4fOYBv+xMidqOl8uT8HJSyn8cUhEgQpBcwKKU3GxrlzAasJ4K9lmSSmhnfXGbPA43t0uzdLTSQMTgV8eplL5pd4H+IOxLOVOhuh4Ve+Hx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068718; c=relaxed/simple;
	bh=3MwBp79XF8yQbzRYrjp0K8+7wPnAY6nbIEcUVtuboSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5SYSg5qpKMHR6YBec+J6r+lN8GxuMxii4PQShoEnIbxQE8S50xZ0z2ke4Jv3t3RcBroSoeocaEll68Opo2uvKd6RdsmzwF/ONnvLKlhCzXx4UCc6XybpDkApr8PBPEWtkJyMI1XSiULi5pBC1X3/V7iSbbumM438cedPcAeT6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gc2WWXI0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gc2WWXI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761068714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00BBNZsx40vUqxznI5nqRnSZsNRMeZr7vS+gFNKfPns=;
	b=Gc2WWXI0+D7zJtd28yGhUrr0RegPazJoDNfBMK7tOZ9c4v99E6trNCP7LCVZWPE8/5sK6H
	uNYQuqddecQter6wUNpE5WLPuFoBoz0nwIO68MOZUYj7EePvGJKKXc3k/d8b3F47q6hd/E
	/7t+vZHZ8bWhJ0us+um/JRezDwApfRE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-Li164GphPoy4oQfahBokmA-1; Tue,
 21 Oct 2025 13:45:10 -0400
X-MC-Unique: Li164GphPoy4oQfahBokmA-1
X-Mimecast-MFC-AGG-ID: Li164GphPoy4oQfahBokmA_1761068709
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D887918002F5;
	Tue, 21 Oct 2025 17:45:07 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D54071800579;
	Tue, 21 Oct 2025 17:45:03 +0000 (UTC)
Date: Tue, 21 Oct 2025 14:45:01 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>, 
	Clark Williams <williams@redhat.com>, marco.chiappero@suse.com, chris.friesen@windriver.com, 
	luochunsheng@ustc.edu
Subject: Re: [PATCH 11/12] scripts: fix run-local if bashism
Message-ID: <evuafhm5h2z7mvlbgvmnyxzucsibjlijpduxhbt5ktozq2wfdj@vtzayoac74vn>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-11-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-11-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 16, 2025 at 09:24:43PM -0500, Clark Williams wrote:
> From: Derek Barbosa <debarbos@redhat.com>
> 
> In older versions of Bash, mainly 4.2.X, a semicolon (or newline) is
> requied after a conditional statement and before the `then` keyword.
> 
> Add the semicolon to allow testing and quick "local runs" on legacy
> kernels.
> 
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  scripts/run-local.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/run-local.sh b/scripts/run-local.sh
> index 0ce147634472..e65f34dd46a4 100755
> --- a/scripts/run-local.sh
> +++ b/scripts/run-local.sh
> @@ -44,7 +44,7 @@ parse_args()
>  # script start
>  #
>  
> -if [[ ! -x ./stalld ]] then
> +if [[ ! -x ./stalld ]]; then
>     echo "No stalld executable in the current directory!"
>     exit 1
>  fi
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

