From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drivers/media: vsp1_video: fix compile error
Date: Mon, 25 Jan 2016 00:15:28 +0200
Message-ID: <1991984.ioj231CKOU@avalon>
References: <1452816583-11036-1-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: mchehab@osg.samsung.com, linux-media@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452816583-11036-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Anders,

Thank you for the patch.

On Friday 15 January 2016 01:09:43 Anders Roxell wrote:
> This was found with the -RT patch enabled, but the fix should apply to
> non-RT also.
> 
> Compilation error without this fix:
> ../drivers/media/platform/vsp1/vsp1_video.c: In function
> 'vsp1_pipeline_stopped':
> ../drivers/media/platform/vsp1/vsp1_video.c:524:2: error: expected
> expression before 'do'
>   spin_unlock_irqrestore(&pipe->irqlock, flags);
>     ^
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/media/platform/vsp1/vsp1_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_video.c
> b/drivers/media/platform/vsp1/vsp1_video.c index 637d0d6..b4dca57 100644
> --- a/drivers/media/platform/vsp1/vsp1_video.c
> +++ b/drivers/media/platform/vsp1/vsp1_video.c
> @@ -515,7 +515,7 @@ static bool vsp1_pipeline_stopped(struct vsp1_pipeline
> *pipe) bool stopped;
> 
>  	spin_lock_irqsave(&pipe->irqlock, flags);
> -	stopped = pipe->state == VSP1_PIPELINE_STOPPED,
> +	stopped = pipe->state == VSP1_PIPELINE_STOPPED;
>  	spin_unlock_irqrestore(&pipe->irqlock, flags);
> 
>  	return stopped;

-- 
Regards,

Laurent Pinchart
