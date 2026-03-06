<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;
use Tymon\JWTAuth\Exceptions\TokenBlacklistedException;

class JwtMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        try {
            $user = JWTAuth::parseToken()->authenticate();
            
            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthenticated',
                    'data' => null
                ], 401);
            }

            // Check if user is approved
            if ($user->status !== 'approved') {
                return response()->json([
                    'success' => false,
                    'message' => 'Your account is not approved. Status: ' . $user->status,
                    'data' => null
                ], 403);
            }

        } catch (TokenBlacklistedException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated',
                'data' => null
            ], 401);

        } catch (TokenExpiredException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated',
                'data' => null
            ], 401);

        } catch (TokenInvalidException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated',
                'data' => null
            ], 401);

        } catch (JWTException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated',
                'data' => null
            ], 401);
        }

        return $next($request);
    }
}
